# encoding: utf-8
module Inforouter #:nodoc:
  module Errors #:nodoc:
    # This error is raised when a SOAP call fails.
    class SOAPError < InforouterError
      # Original SOAP fault.
      attr_reader :fault

      def initialize(e)
        @fault = e
        e.to_hash.tap do |fault|
          fault_code = fault[:fault][:faultcode]
          fault_string = parse_fault(fault[:fault][:faultstring])
          super(compose_message('soap_error',
                                :message => fault_string,
                                :code => fault_code
          ))
        end
      end

      private

      # @param fault_string [String]
      #
      # @return [String]
      def parse_fault(fault_string)
        fault_string.lines.first.strip
      end
    end
  end
end
