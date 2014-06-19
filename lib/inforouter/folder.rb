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

    def exists?
      message = { :path => @path }
      response = Inforouter.client.request :folder_exists, message
      result = Inforouter::Responses::FolderExists.parse response
      result[:@success] == 'true'
    end
  end
end
