module Inforouter #:nodoc:
  module Responses #:nodoc:
    # A generic response to an Inforouter API call.
    class Generic < Base
      # Response key.
      class_attribute :key

      class << self
        # Set the response key.
        #
        # @param key [String]
        def response_key(key)
          self.key = key
          response_type "#{key}_response/#{key}_result/response"
          error_message "#{key}_response/#{key}_result/respone/@error"
        end

        # Parse an Inforouter response.
        #
        # @param savon_response [Savon::Response]
        def parse(savon_response)
          response = new(savon_response)
          response.raw["#{key}_response".to_sym]["#{key}_result".to_sym][:response]
        end
      end
    end
  end
end
