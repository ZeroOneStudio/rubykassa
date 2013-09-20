# -*- encoding : utf-8 -*-
require 'rubykassa/configuration'

module Rubykassa
  class ConfigurationError < StandardError
    class << self
      def raise_errors_for configuration
        raise ConfigurationError, "Available modes are :test or :production" unless [:test, :production].include? configuration.mode
        raise ConfigurationError, "Available http methods are :get or :post" unless [:get, :post].include? configuration.http_method
        raise ConfigurationError, "Available xml http methods are :get or :post" unless [:get, :post].include? configuration.xml_http_method
      end
    end
  end

  class Client
    class << self
      attr_accessor :configuration

      def configure
        self.configuration = Rubykassa::Configuration.new
        yield self.configuration
        ConfigurationError.raise_errors_for self.configuration
      end
    end
  end
end
