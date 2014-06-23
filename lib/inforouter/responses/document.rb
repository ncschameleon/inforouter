module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Get Document API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=GetDocument

    class Document < Base
      response_success 'get_document_response/get_document_result/response/@success'
      error_message 'get_document_response/get_document_result/response/@error'

      class << self
        # Parse an infoRouter response.
        #
        # @param savon_response [Savon::Response] SOAP response.
        #
        # @return [Inforouter::Document]
        def parse(savon_response)
          response = new(savon_response)
          document = response.match('get_document_response/get_document_result/response/document')
          Inforouter::Document.new(
            :document_id => document[:@folder_id].to_i,
            :name => document[:@name].strip,
            :path => document[:@path].strip,
            :description => document[:@description].strip,
            :update_instructions => document[:@update_instructions].strip,
            :creation_date => DateTime.strptime(document[:@creation_date], '%Y-%m-%d %H:%M:%S'),
            :modification_date => DateTime.strptime(document[:@modification_date], '%Y-%m-%d %H:%M:%S'),
            :checkout_date => DateTime.strptime(document[:@checkout_date], '%Y-%m-%d %H:%M:%S'),
            :checkout_by => document[:@checkout_by].strip,
            :checkout_by_user_name => document[:@checkout_by_user_name].strip,
            :size => document[:@size].to_i,
            :type => document[:@type].strip,
            :percent_complete => document[:@percent_complete].to_i,
            :importance => document[:@importance].to_i,
            :retention_date => DateTime.strptime(document[:@retention_date], '%Y-%m-%d %H:%M:%S'),
            :disposition_date => DateTime.strptime(document[:@disposition_date], '%Y-%m-%d %H:%M:%S'),
            :doc_type_id => document[:@doc_type_id].to_i,
            :doc_type_name => document[:@doc_type_id].strip,
            :version_number => document[:@version_number].to_i
          )
        end
      end
    end
  end
end
