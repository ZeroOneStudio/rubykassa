module Rubykassa
  module SignatureGenerator
    def generate_signature_for kind
      raise ArgumentError, "Available kinds are only :payment or :success" if ![:success, :payment, :response].include? kind
      custom_param_keys = @params.keys.select {|key| key =~ /^shp/}.sort
      custom_params = custom_param_keys.map {|key| "#{key}=#{params[key]}"}
      custom_params_string = custom_params.present? ? ":#{custom_params}" : ""

      if kind == :payment  
        password = Rubykassa.first_password
        string = [Rubykassa.login, @total, @invoice_id, password].join(":") + custom_params_string
      elsif kind == :response
        password = Rubykassa.second_password
        string = [@total, @invoice_id, password].join(":") + custom_params_string
      elsif kind = :success
        password = Rubykassa.first_password
        string = [@total, @invoice_id, password].join(":") + custom_params_string
      end

      signature = Digest::MD5.hexdigest(string)
    end
  end
end