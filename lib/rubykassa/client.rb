# -*- encoding : utf-8 -*-
require 'rubykassa/configuration'

module Rubykassa
  class ConfigurationError < StandardError; end

  class Client
    class << self
      attr_accessor :configuration

      def configure
        self.configuration = Rubykassa::Configuration.new
        yield self.configuration

        raise ConfigurationError, "Available modes are :test or :production" unless [:test, :production].include? self.configuration.mode
        raise ConfigurationError, "Available http methods are :get or :post" unless [:get, :post].include? self.configuration.http_method
        raise ConfigurationError, "Available xml http methods are :get or :post" unless [:get, :post].include? self.configuration.xml_http_method
      end
    end
  end
end
