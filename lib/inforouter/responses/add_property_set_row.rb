module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Add Property Set Row API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=AddPropertySetRow
    class AddPropertySetRow < Generic
      response_key :add_property_set_row
    end
  end
end
