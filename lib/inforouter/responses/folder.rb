module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Get Folder API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=GetFolder
    class Folder < Base
      response_success 'get_folder_response/get_folder_result/response/@success'
      error_message 'get_folder_response/get_folder_result/response/@error'

      class << self
        # Parse an infoRouter response.
        #
        # @param savon_response [Savon::Response] SOAP response.
        #
        # @return [Inforouter::Folder]
        def parse(savon_response)
          response = new(savon_response)
          data = response.match('get_folder_response/get_folder_result/response')
          return nil if data[:folder].nil?
          folder = data[:folder]
          Inforouter::Folder.new(
            property_sets: parse_property_sets(folder[:propertysets]),
            id: folder[:@folder_id].to_i,
            parent_id: folder[:@parent_id].to_i,
            name: folder[:@name].strip,
            path: folder[:@path].strip,
            description: folder[:@description].strip,
            creation_date: parse_datetime(folder[:@creation_date]),
            owner_name: folder[:@owner_name].strip,
            domain_id: folder[:@domain_id].to_i
          )
        end

        private

        def parse_property_sets(propertysets)
          return [] if propertysets.nil?
          property_sets = []
          propertysets = [propertysets] if propertysets.is_a?(Hash)
          propertysets.each do |propertyset|
            propertyrows = propertyset[:propertyset][:propertyrow]
            next if propertyrows.nil?
            propertyrows = [propertyrows] if propertyrows.is_a?(Hash)
            # Create a property set and add rows.
            property_set = Inforouter::PropertySet.new name: propertyset[:propertyset][:@name]
            propertyrows.each do |propertyrow|
              property_set.rows << Inforouter::PropertyRow.new(propertyrow)
            end
            property_sets << property_set
          end
          property_sets
        end
      end
    end
  end
end
