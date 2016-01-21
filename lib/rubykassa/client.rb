# -*- encoding : utf-8 -*-
require 'rubykassa/configuration'

module Rubykassa
  class ConfigurationError < StandardError
    class << self
      def raise_errors_for(configuration)
        if !configuration.correct_mode?
          raise ConfigurationError, "Ivalid mode: only :test or :production are allowed"
        end

        if !configuration.correct_http_method? || !configuration.correct_xml_http_method?
          raise ConfigurationError, "Ivalid http method: only :get or :post are allowed"
        end
      end
    end
  end

  class Client
    class << self
      attr_accessor :configuration

      def configure
        self.configuration = Rubykassa::Configuration.new
        yield self.configuration
        ConfigurationError.raise_errors_for(self.configuration)
      end
    end
  end
end
