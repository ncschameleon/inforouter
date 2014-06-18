module Inforouter #:nodoc:
  # infoRouter gem configuration.
  class Configuration
    # infoRouter WSDL.
    attr_accessor :wsdl
    # infoRouter host.
    attr_accessor :host
    # infoRouter username.
    attr_accessor :username
    # infoRouter password.
    attr_accessor :password

    def initialize(options = {})
      @wsdl = options[:wsdl] || File.dirname(__FILE__) + '/../../resources/inforouter.wsdl'
    end

    # Check the configuration.
    #
    # Will raise a Inforouter::Errors::MissingConfigOption if any of the host or
    # the username are missing.
    def check!
      fail Inforouter::Errors::MissingConfigOption.new('host') unless host && host.strip.length > 0
      fail Inforouter::Errors::MissingConfigOption.new('username') unless username && username.strip.length > 0
    end
  end
end
