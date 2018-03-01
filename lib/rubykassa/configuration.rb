module Rubykassa
  class Configuration
    ATTRIBUTES = [
      :login, :first_password, :second_password, :currency, :mode, :http_method,
      :xml_http_method, :success_callback, :fail_callback, :result_callback,
      :hash_algorithm
    ]
    HASH_ALGORITHMS = [:md5, :ripemd160, :sha1, :sha256, :sha384, :sha512]

    attr_accessor *ATTRIBUTES

    def initialize
      self.login = 'your_login'
      self.first_password   = 'first_password'
      self.second_password  = 'second_password'
      self.currency  = 'currency'
      self.mode             = :test
      self.http_method      = :get
      self.xml_http_method  = :get
      self.hash_algorithm   = :md5
      self.success_callback = ->(notification) { render text: 'success' }
      self.fail_callback    = ->(notification) { render text: 'fail' }
      self.result_callback  = ->(notification) do
        render text: notification.success
      end
    end

    def correct_mode?
      [:test, :production].include?(mode)
    end

    def correct_http_method?
      [:get, :post].include?(http_method)
    end

    def correct_xml_http_method?
      [:get, :post].include?(xml_http_method)
    end

    def correct_hash_algorithm?
      HASH_ALGORITHMS.include?(hash_algorithm)
    end
  end
end
