module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Update Folder Properties API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=UpdateFolderProperties
    class UpdateFolderProperties < Generic
      response_key :update_folder_properties
    end
  end
end
