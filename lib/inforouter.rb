require 'savon'
require 'i18n'
require 'active_support'
require 'active_support/core_ext'

require 'inforouter/version'
require 'inforouter/errors'
require 'inforouter/responses'
require 'inforouter/record'
require 'inforouter/access_list'
require 'inforouter/access_list_domain_members_item'
require 'inforouter/access_list_user_group_item'
require 'inforouter/access_list_user_item'
require 'inforouter/document'
require 'inforouter/folder'
require 'inforouter/property_set'
require 'inforouter/property_row'
require 'inforouter/rights'
require 'inforouter/rule_item'
require 'inforouter/rules'
require 'inforouter/user'
require 'inforouter/users'
require 'inforouter/configuration'
require 'inforouter/client'

I18n.load_path << File.join(File.dirname(__FILE__), 'config', 'locales', 'en.yml')

module Inforouter
  class << self
    attr_accessor :configuration

    # infoRouter API version.
    API_VERSION = '8.0'

    # Returns true if the gem has been configured.
    def configured?
      !configured.nil?
    end

    # Configure the gem
    def configure
      self.configuration ||= Configuration.new
      yield configuration
    end

    def reset!
      self.configuration = nil
      @client = nil
    end

    def client(options = {})
      check_configuration!
      @client ||= Inforouter::Client.new(options)
    end

    private

    def check_configuration!
      fail Inforouter::Errors::MissingConfig.new unless self.configuration
      self.configuration.check!
    end
  end
end
