module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Set Access List API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=SetAccessList
    class SetAccessList < Generic
      response_key :set_access_list
    end
  end
end
