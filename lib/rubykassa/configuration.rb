# -*- encoding : utf-8 -*-
module Rubykassa
  class Configuration
    attr_accessor :login, :first_password, :second_password, :mode, :http_method, :xml_http_method
    attr_accessor :success_callback
    attr_accessor :fail_callback
    attr_accessor :result_callback

    def initialize
      self.login = "your_login"
      self.first_password = "first_password"
      self.second_password = "second_password"
      self.mode = :test
      self.http_method = :get
      self.xml_http_method = :get
      self.success_callback = Proc.new do |controller, notification|
        render text: 'success'
      end
      self.fail_callback = Proc.new do |controller, notification|
        render text: 'fail'
      end
      self.result_callback = Proc.new do |controller, notification|
        render text: notification.success
      end      
    end
  end
end