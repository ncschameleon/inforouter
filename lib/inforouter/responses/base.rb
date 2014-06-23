module Inforouter #:nodoc:
  module Responses #:nodoc:
    # A base infoRouter SOAP response.
    class Base
      # Raw response.
      attr_accessor :raw

      # @param savon_response [Savon::Response]
      def initialize(savon_response)
        @raw = savon_response.to_hash
        parse!
      end

      class << self
        # Location of the response in the SOAP XML.
        def response_success(value)
          set_dsl(:response_success, value)
        end

        # Location of the error message in the SOAP XML.
        def error_message(value)
          set_dsl(:error_message, value)
        end

        # Parse a SOAP response.
        #
        # @param savon_response [Savon::Response]
        def parse(savon_response)
          new(savon_response)
        end
      end

      # Match an element in the SOAP response
      #
      # @param match [String] XML path to match.
      def match(chain)
        current_value = raw
        chain.split('/').each do |key|
          current_value = current_value[key.to_sym]
          next if current_value
          fail Inforouter::Errors::UnexpectedSOAPResponse.new(raw, key, chain)
        end
        current_value
      end

      private

      class_attribute :dsl

      class << self
        def set_dsl(key, value)
          self.dsl ||= {}
          self.dsl[key] = value
          self.dsl
        end
      end

      def parse!
        if self.dsl[:response_success]
          return true if match(self.dsl[:response_success]) == 'true'
        end
        if self.dsl[:error_message]
          return true if match(self.dsl[:error_message]) == ''
          # TODO
        end
      end
    end
  end
end
