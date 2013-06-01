require 'rubykassa/action_view_extension'

module Rubykassa
  class Engine < ::Rails::Engine
    initializer "rubykassa.action_view_extension" do
      ActionView::Base.send :include, Rubykassa::ActionViewExtension
    end
  end
end
