module Inforouter #:nodoc:
  # A <tt>Folder</tt> defines an infoRouter folder.
  class Folder < Record
    # Folder ID.
    attr_accessor :id
    # Folder parent ID.
    attr_accessor :parent_id
    # Folder name.
    attr_accessor :name
    # Folder path.
    attr_accessor :path
    # Folder description.
    attr_accessor :description
    # Folder creation date.
    attr_accessor :creation_date
    # Folder owner name.
    attr_accessor :owner_name
    # Folder domain ID.
    attr_accessor :domain_id
    # Folder access list.
    attr_accessor :access_list
    # Folder property sets. Array of <tt>Inforouter::PropertySet</tt>s.
    attr_accessor :property_sets
    # Folder rules.
    attr_accessor :rules
    # Folder folders. Array of <tt>Inforouter::Folder</tt>s.
    attr_accessor :folders
    # Folder documents. Array of <tt>Inforouter::Document</tt>s.
    attr_accessor :documents

    # Find by path.
    def self.find(options = {})
      folder = Folder.new(options)
      response = Inforouter.client.request :get_folder, folder.send(:folder_params)
      Inforouter::Responses::Folder.parse response
    end

    def description
      @description ||= begin
        response = Inforouter.client.request :get_folder, folder_params
        folder = Inforouter::Responses::Folder.parse response
        @description = folder.description
      end
    end

    def documents
      @documents ||= begin
        response = Inforouter.client.request :get_documents1, path_params
        @documents = Inforouter::Responses::Documents.parse response
      end
    end

    def folders
      @folders ||= begin
        response = Inforouter.client.request :get_folders1, path_params
        @folders = Inforouter::Responses::Folders.parse response
      end
    end

    def property_sets
      @property_sets ||= begin
        response = Inforouter.client.request :get_folder, folder_params(with_property_sets: true)
        folder = Inforouter::Responses::Folder.parse response
        @property_sets = folder.property_sets
      end
    end

    # Setting the path also sets the name if not already set.
    def path=(path)
      @name ||= path.split('/').last
      @path = path
    end

    # @return [Boolean]
    def create
      response = Inforouter.client.request :create_folder, path_params
      result = Inforouter::Responses::CreateFolder.parse response
      result[:@success] == 'true'
    end

    # @return [Boolean]
    def exists?
      response = Inforouter.client.request :folder_exists, path_params
      result = Inforouter::Responses::FolderExists.parse response
      result[:@success] == 'true'
    end

    # @return [Boolean]
    def update_access_list(options = {})
      options = { apply_to_tree: false }.merge(options)
      request_params = {
        :path => path,
        'AccessListXML' => access_list.to_xml,
        :apply_to_tree => options[:apply_to_tree] ? 1 : 0
      }
      response = Inforouter.client.request :set_access_list, request_params
      result = Inforouter::Responses::SetAccessList.parse response
      result[:@success] == 'true'
    end

    # @return [Boolean]
    def update_properties
      request_params = {
        path: path,
        new_folder_name: name,
        new_description: description
      }
      response = Inforouter.client.request :update_folder_properties, request_params
      result = Inforouter::Responses::UpdateFolderProperties.parse response
      result[:@success] == 'true'
    end

    # Property Sets.

    # @return [Boolean]
    def add_property_sets
      request_params = {
        :path => path,
        'xmlpset' => PropertySet.to_xml(property_sets)
      }
      response = Inforouter.client.request :add_property_set_row, request_params
      result = Inforouter::Responses::AddPropertySetRow.parse response
      result[:@success] == 'true'
    end

    # @return [Boolean]
    def delete_property_set!(name)
      # Select property set by name.
      property_set = @property_sets.select { |p| p.name == name }.first
      return false unless property_set
      request_params = {
        :path => path,
        'xmlpset' => property_set.delete_xml
      }
      response = Inforouter.client.request :delete_property_set_row, request_params
      result = Inforouter::Responses::DeletePropertySetRow.parse response
      if result[:@success] == 'true'
        @property_sets.reject! { |p| p.name == name }
      end
      result[:@success] == 'true'
    end

    # @return [Boolean]
    def update_property_sets
      request_params = {
        :path => path,
        'xmlpset' => PropertySet.to_xml(property_sets)
      }
      response = Inforouter.client.request :update_property_set_row, request_params
      result = Inforouter::Responses::UpdatePropertySetRow.parse response
      result[:@success] == 'true'
    end

    # Rules.

    # @return [Boolean]
    def update_rules(options = {})
      options = { apply_to_tree: false }.merge(options)
      request_params = {
        :path => path,
        'xmlRules' => rules.to_hash,
        :apply_to_tree => options[:apply_to_tree] ? 1 : 0
      }
      response = Inforouter.client.request :set_folder_rules, request_params
      result = Inforouter::Responses::SetFolderRules.parse response
      result[:@success] == 'true'
    end

    private

    # @return [Hash]
    def path_params
      { path: path }
    end

    # @return [Hash]
    def folder_params(options = {})
      options = { with_property_sets: true }.merge(options)
      {
        :path => path,
        :with_rules => 0,
        'withPropertySets' => options[:with_property_sets] ? 1 : 0,
        'withSecurity' => 0,
        'withOwner' => 0
      }
    end
  end
end
