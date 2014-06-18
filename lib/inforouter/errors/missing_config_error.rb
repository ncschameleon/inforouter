# encoding: utf-8
module Inforouter #:nodoc:
  module Errors #:nodoc:
    # This error is raised when attempting to create a new client without
    # configuring infoRouter.
    class MissingConfigError < InforouterError
      # Create a new error.
      def initialize
        super(compose_message('missing_config'))
      end
    end
  end
end
