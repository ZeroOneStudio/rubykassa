require 'rails/generators'

module Rubykassa
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    def create_initializer_file
      template 'rubykassa.rb',
               File.join('config', 'initializers', 'rubykassa.rb')
    end     
  end
end
