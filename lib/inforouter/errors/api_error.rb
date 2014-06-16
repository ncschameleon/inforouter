# encoding: utf-8
module Inforouter #:nodoc:
  module Errors #:nodoc:
    # This error is raised when the Inforouter service
    # returns an error from an API.
    class ApiError < InforouterError
      # @param message [String] Error message.
      # @param raw [String] Raw data from the SOAP response.
      def initialize(message, raw)
        super(compose_message('api_error',
                              :message => message,
                              :raw => raw
        ))
      end
    end
  end
end
