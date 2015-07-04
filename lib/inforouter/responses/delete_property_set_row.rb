module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Delete Property Set Row API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=DeletePropertySetRow
    class DeletePropertySetRow < Generic
      response_key :delete_property_set_row
    end
  end
end
