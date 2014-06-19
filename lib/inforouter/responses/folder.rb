module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Get Folder API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=GetFolder
    class GetFolder < Generic
      response_key :get_folder
    end
  end
end
