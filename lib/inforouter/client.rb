module Inforouter
  # A <tt>Client</tt> communicates with the Inforouter service.
  class Client
    attr_reader :client, :ticket, :wsdl

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

      @wsdl = options[:wsdl] || File.dirname(__FILE__) + '/../../resources/inforouter.wsdl'

      @client = Savon.client(
        :wsdl => @wsdl,
        :convert_request_keys_to => :camelcase,
        :pretty_print_xml => true,
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
      get_ticket unless is_valid_ticket?(@ticket)
      return @ticket
    end

    # Make a safe SOAP call.
    # Will raise a Inforouter::Errors::SOAPError on error.
    #
    # @param method [Symbol]
    # @param message [Hash]
    def call(method, message = {})
      safe do
        super method, :message => message.merge(authentication_params)
      end
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
      begin
        yield
      rescue Savon::SOAPFault => e
        raise Inforouter::Errors::SOAPError.new(e)
      end
    end

    # Get a ticket.
    def get_ticket
      # AuthenticateUser
      # Authenticates the specified user against infoRouter.
      response = @client.call(:authenticate_user, :message => message_params)
      if response.success?
        data = response.to_array(:authenticate_user_response,
                                 :authenticate_user_result,
                                 :response).first
        @ticket = data[:@ticket] if data[:@success] == 'true'
      end
    end

    # Determines whether the given ticket is still valid or not.
    #
    # @params ticket [String]
    # @return [Boolean]
    def is_valid_ticket?(ticket)
      # isValidTicket
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
      return result
    end
  end
end
