module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Folder Exists API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=FolderExists
    class FolderExists < Generic
      response_key :folder_exists
    end
  end
end
