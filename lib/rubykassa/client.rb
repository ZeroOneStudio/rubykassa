require 'rubykassa/configuration'

module Rubykassa
  class Client
    class << self
      attr_accessor :configuration

      def configure
        self.configuration = Rubykassa::Configuration.new
        yield self.configuration  
      end
    end
  end
end