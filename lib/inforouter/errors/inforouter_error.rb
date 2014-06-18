# encoding: utf-8
module Inforouter #:nodoc:
  module Errors #:nodoc:
    # Default parent infoRouter error for all custom errors. This handles the
    # base key for the translations and provides the convenience method for
    # translating the messages.
    #
    # Generously borrowed from Mongoid[https://github.com/mongoid/mongoid/blob/master/lib/mongoid/errors/mongoid_error.rb].
    class InforouterError < StandardError
      BASE_KEY = 'inforouter.errors.messages' #:nodoc:

      # Compose the message.
      #
      # @example Create the message.
      #   error.compose_message
      #
      # @return [String] The composed message.
      def compose_message(key, attributes = {})
        @problem = problem(key, attributes)
        @summary = summary(key, attributes)
        @resolution = resolution(key, attributes)

        "\nProblem:\n  #{@problem}" +
        "\nSummary:\n  #{@summary}" +
        "\nResolution:\n  #{@resolution}"
      end

      private

      # Given the key of the specific error and the options hash, translate the
      # message.
      #
      # @example Translate the message.
      #   error.translate("errors", :key => value)
      #
      # @param key [String] The key of the error in the locales.
      # @param options [Hash] The objects to pass to create the message.
      #
      # @return [String] A localized error message string.
      def translate(key, options)
        ::I18n.translate("#{BASE_KEY}.#{key}", options)
      end

      # Create the problem.
      #
      # @example Create the problem.
      #   error.problem("error", {})
      #
      # @param key [String, Symbol] The error key.
      # @param attributes [Hash] The attributes to interpolate.
      #
      # @return [String] The problem.
      def problem(key, attributes)
        translate("#{key}.problem", attributes)
      end

      # Create the summary.
      #
      # @example Create the summary.
      #   error.summary("error", {})
      #
      # @param key [String, Symbol] The error key.
      # @param attributes [Hash] The attributes to interpolate.
      #
      # @return [String] The summary.
      def summary(key, attributes)
        translate("#{key}.summary", attributes)
      end

      # Create the resolution.
      #
      # @example Create the resolution
      #   error.resolution("error", {})
      #
      # @param key [String, Symbol] The error key.
      # @param attributes [Hash] The attributes to interpolate.
      #
      # @return [String] The resolution.
      def resolution(key, attributes)
        translate("#{key}.resolution", attributes)
      end
    end
  end
end
