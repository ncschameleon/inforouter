module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Returns the list of documents in the specified path in short form.
    #
    # http://www.inforouter.com/web-services-80/default.aspx?op=GetDocuments1
    class Documents < Base
      response_success 'get_documents1_response/get_documents1_result/response/@success'
      error_message 'get_documents1_response/get_documents1_result/response/@error'

      class << self
        # Parse an infoRouter response.
        #
        # @param savon_response [Savon::Response] SOAP response.
        #
        # @return [Array<Inforouter::Document>]
        def parse(savon_response)
          response = new(savon_response)
          data = response.match('get_documents1_response/get_documents1_result/response')
          return [] if data[:@itemcount].to_i == 0
          data[:d] = [data[:d]] if data[:d].is_a?(Hash)
          data[:d].map do |document|
            Inforouter::Document.new(
              id: document[:@id].to_i,
              name: document[:@n].strip,
              modification_date: parse_datetime(document[:@mdate]),
              creation_date: parse_datetime(document[:@cdate]),
              size: document[:@size].to_i,
              description: document[:@dformat].strip,
              checkout_by_username: document[:@chkoutbyusername].strip,
              checkout_by_full_name: document[:@chkoutbyfullname].strip,
              version: document[:@version].to_i,
              register_date: parse_datetime(document[:@regdate]),
              published_version: document[:@publishedversion].to_i,
              type: document[:@dtype].to_i
            )
          end
        end
      end
    end
  end
end
