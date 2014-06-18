module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Update Property Set Row API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=UpdatePropertySetRow
    class UpdatePropertySetRow < Generic
      response_key :update_property_set_row
    end
  end
end
