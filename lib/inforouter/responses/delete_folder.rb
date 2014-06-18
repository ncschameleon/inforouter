module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Delete Folder API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=DeleteFolder
    class DeleteFolder < Generic
      response_key :delete_folder
    end
  end
end
