require "rubykassa/engine"
require 'rubykassa/client'

module Rubykassa
  extend self

  def configure &block
    Rubykassa::Client.configure &block
  end

  %w(login first_password second_password).map do |name|
    define_method name do
      Rubykassa::Client.configuration.send(name)
    end
  end
end
