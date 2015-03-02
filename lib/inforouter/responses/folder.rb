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
      end
    end
  end
end
