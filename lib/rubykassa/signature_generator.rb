# -*- encoding : utf-8 -*-
module Rubykassa
  module SignatureGenerator
    def generate_signature_for kind
      raise ArgumentError, "Available kinds are only :payment, :result or :success" unless [:success, :payment, :result].include? kind
      custom_params = @params.keys.select {|key| key =~ /^shp/ }.sort.map {|key| "#{key}=#{params[key]}"}
      custom_params_string = custom_params.present? ? ":#{custom_params}" : ""
      
      Digest::MD5.hexdigest(params_string(kind, custom_params_string))
    end
  end
  
  def params_string kind, custom_params_string
    case kind
    when :payment
      string = [Rubykassa.login, @total, @invoice_id, Rubykassa.first_password].join(":") + custom_params_string
    when :result
      string = [@total, @invoice_id, Rubykassa.second_password].join(":") + custom_params_string
    when :success
      string = [@total, @invoice_id, Rubykassa.first_password].join(":") + custom_params_string
    end
  end
end
