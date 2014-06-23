module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Document Exists API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=DocumentExists
    class DocumentExists < Generic
      response_key :document_exists
    end
  end
end
