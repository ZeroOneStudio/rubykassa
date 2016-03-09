require 'rubykassa/configuration'

module Rubykassa
  class ConfigurationError < StandardError
    ENV_MESSAGE =
      'Invalid mode: only :test or :production are allowed'.freeze
    HTTP_METHOD_MESSAGE =
      'Invalid http method: only :get or :post are allowed'.freeze

    def self.raise_errors_for(configuration)
      if !configuration.correct_mode?
        raise ConfigurationError, ENV_MESSAGE
      end
      if !configuration.correct_http_method? ||
          !configuration.correct_xml_http_method?
        raise ConfigurationError, HTTP_METHOD_MESSAGE
      end
    end
  end

  class Client
    cattr_accessor :configuration
    def self.configure
      self.configuration = Rubykassa::Configuration.new
      yield self.configuration
      ConfigurationError.raise_errors_for(self.configuration)
    end
  end
end
