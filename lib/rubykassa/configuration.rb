# -*- encoding : utf-8 -*-
module Rubykassa
  class Configuration
    ATTRIBUTES = [
      :login, :first_password, :second_password, :mode, :http_method, :xml_http_method,
      :success_callback, :fail_callback, :result_callback
    ]

    attr_accessor *ATTRIBUTES

    def initialize
      self.login = "your_login"
      self.first_password   = "first_password"
      self.second_password  = "second_password"
      self.mode             = :test
      self.http_method      = :get
      self.xml_http_method  = :get
      self.success_callback = ->(notification) { render text: 'success' }
      self.fail_callback    = ->(notification) { render text: 'fail' }
      self.result_callback  = ->(notification) { render text: notification.success   }
    end
  end
end