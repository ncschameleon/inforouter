# encoding: utf-8
module Inforouter #:nodoc:
  module Errors #:nodoc:
    # This error is raised when a configuration option is missing.
    class MissingConfigOption < InforouterError
      # @param name [String]
      def initialize(name)
        super(compose_message('missing_config_option', name: name))
      end
    end
  end
end
