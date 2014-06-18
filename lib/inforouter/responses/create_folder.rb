module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Create Folder API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=CreateFolder
    class CreateFolder < Generic
      response_key :create_folder
    end
  end
end
