module Inforouter
  # A <tt>Client</tt> communicates with the infoRouter service.
  class Client
    attr_reader :client, :ticket

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Inforouter::Client]
    def initialize(options = {})
      options = {
        :log => false,
        :logger => Logger.new($stdout),
        :log_level => :info
      }.merge(options)

      @client = Savon.client(
        :wsdl => Inforouter.configuration.wsdl,
        :convert_request_keys_to => :camelcase,
        :pretty_print_xml => true,
        :ssl_verify_mode => :none,
        :log => options[:log],
        :logger => options[:logger],
        :log_level => options[:log_level]
      )

      @ticket = nil
    end

    # @return [Array]
    def operations
      @client.operations
    end

    # Returns the client ticket.
    #
    # @return [String]
    def ticket
      @ticket = authenticate_user unless valid_ticket?(@ticket)
      @ticket
    end

    # Make a safe SOAP call.
    # Will raise a Inforouter::Errors::SOAPError on error.
    #
    # @param method [Symbol]
    # @param message [Hash]
    def call(method, message = {})
      safe do
        @client.call method, :message => message.merge(authentication_params)
      end
    end

    def request(method, message = {})
      call method, message
    end

    private

    # @return [Hash]
    def message_params
      return {} unless Inforouter.configuration
      {
        'UID' => Inforouter.configuration.username,
        'PWD' => Inforouter.configuration.password
      }
    end

    # @return [Hash]
    def authentication_params
      {
        :authentication_ticket => ticket
      }
    end

    def safe(&block)
      yield
      rescue Savon::SOAPFault => e
        raise Inforouter::Errors::SOAPError.new(e)
    end

    # Authenticate the specified user against infoRouter and returns a ticket.
    #
    # @return [String]
    def authenticate_user
      ticket = nil
      response = @client.call(:authenticate_user, :message => message_params)
      if response.success?
        data = response.to_array(:authenticate_user_response,
                                 :authenticate_user_result,
                                 :response).first
        ticket = data[:@ticket] if data[:@success] == 'true'
      end
      ticket
    end

    # Determines whether the given ticket is still valid or not.
    #
    # @params ticket [String]
    # @return [Boolean]
    def valid_ticket?(ticket)
      result = false
      unless ticket.nil?
        message = { :authentication_ticket => ticket }
        response = @client.call(:is_valid_ticket, :message => message)
        if response.success?
          data = response.to_array(:is_valid_ticket_response,
                                   :is_valid_ticket_result,
                                   :response).first
          result = true if data[:@success] == 'true'
        end
      end
      result
    end
  end
end
