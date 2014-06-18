module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Update Property Set Definition API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=UpdatePropertySetDefinition
    class UpdatePropertySetDefinition < Generic
      response_key :update_property_set_definition
    end
  end
end
