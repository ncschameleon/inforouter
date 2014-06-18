# encoding utf-8
module Inforouter #:nodoc:
  module Errors #:nodoc:
    # This error is raised when infoRouter returns an unexpected SOAP response.
    class UnexpectedSOAPResponse < InforouterError
      # @param raw [String] Raw data from the SOAP response.
      # @param key [String] Expected key in the SOAP response.
      # @param chain [String] Complete SOAP response chain in which the key could not be found.
      def initialize(raw, key, chain)
        super(compose_message('unexpected_soap_response',
                              :key => key,
                              :raw => raw,
                              :chain => chain
        ))
      end
    end
  end
end
