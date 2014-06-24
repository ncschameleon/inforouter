module Inforouter #:nodoc:
  # A <tt>Folder</tt> defines an infoRouter folder.
  class Folder < Record
    # Folder ID.
    attr_accessor :folder_id
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

    def initialize(params = {})
      params = { :property_sets => [] }.merge(params)
      super params
    end

    def description
      @description ||= begin
        response = Inforouter.client.request :get_folder, folder_params
        folder = Inforouter::Responses::Folder.parse response
        @description = folder.description
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
    def update_properties
      request_params = {
        :path => path,
        :new_folder_name => name,
        :description => description
      }
      response = Inforouter.client.request :update_folder_properties, request_params
      result = Inforouter::Responses::UpdateFolderProperties.parse response
      result[:@success] == 'true'
    end

    # @return [Boolean]
    def update_property_sets
      request_params = {
        :path => path,
        'xmlpset' => PropertySet.to_xml(property_sets)
      }
      response = Inforouter.client.request :update_property_set_row, path_params
      result = Inforouter::Responses::UpdatePropertySetRow response
      result[:@success] == 'true'
    end

    # @return [Boolean]
    def update_rules(options = {})
      options = { :apply_to_tree => false }.merge(options)
      request_params = {
        :path => path,
        'xmlRules' => rules.to_xml,
        :apply_to_tree => options[:apply_to_tree] ? 1 : 0
      }
      response = Inforouter.client.request :set_folder_rules, request_params
      result = Inforouter::Responses::SetFolderRules.parse response
      result[:@success] == 'true'
    end

    private

    # @return [Hash]
    def path_params
      { :path => path }
    end

    # @return [Hash]
    def folder_params
      {
        :path => path,
        :with_rules => 0,
        'withPropertySets' => 0,
        'withSecurity' => 0,
        'withOwner' => 0
      }
    end
  end
end
