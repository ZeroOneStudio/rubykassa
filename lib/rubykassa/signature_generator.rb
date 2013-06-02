module Rubykassa
  module SignatureGenerator
    def generate_signature_for kind = :payment
      raise ArgumentError, "Available kinds are only :payment or :success" if ![:payment, :response].include? kind

      password = kind == :payment ? Rubykassa.first_password : Rubykassa.second_password

      custom_param_keys = @params.keys.select {|key| key =~ /^shp/}.sort
      custom_params = custom_param_keys.map {|key| "#{key}=#{params[key]}"}
      string = [Rubykassa.login, @total, @invoice_id, password, custom_params].join(":")
      signature = Digest::MD5.hexdigest(string)
    end
  end
end