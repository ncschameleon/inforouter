module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Get Access List API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=GetAccessList
    class AccessList < Generic
      response_key :get_access_list
    end
  end
end
