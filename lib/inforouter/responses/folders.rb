module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Returns the list of sub folders in the specified path in short form.
    #
    # http://www.inforouter.com/web-services-80/default.aspx?op=GetFolders1
    class Folders < Base
      response_success 'get_folders1_response/get_folders1_result/response/@success'
      error_message 'get_folders1_response/get_folders1_result/response/@error'

      class << self
        # Parse an infoRouter response.
        #
        # @param savon_response [Savon::Response] SOAP response.
        #
        # @return [Array<Inforouter::Folder>]
        def parse(savon_response)
          response = new(savon_response)
          data = response.match('get_folders1_response/get_folders1_result/response')
          return [] if data[:@itemcount].to_i == 0
          # Single folder returned as a Hash.
          data[:f] = [data[:f]] if data[:f].is_a?(Hash)
          data[:f].map do |folder|
            Inforouter::Folder.new(
              id: folder[:@id].to_i,
              name: folder[:@n].strip
            )
          end
        end
      end
    end
  end
end
