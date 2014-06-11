module Inforouter #:nodoc:
  # Inforouter gem configuration.
  class Configuration
    # Inforouter host.
    attr_accessor :host
    # Inforouter username.
    attr_accessor :username
    # Inforouter password.
    attr_accessor :password

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
