# -*- encoding : utf-8 -*-
module Rubykassa
  module SignatureGenerator
    def generate_signature_for kind
      raise ArgumentError, "Available kinds are only :payment, :result or :success" unless [:success, :payment, :result].include? kind      
      Digest::MD5.hexdigest(params_string(kind))
    end

    def params_string kind
      string = case kind
      when :payment
        [Rubykassa.login, @total, @invoice_id, Rubykassa.first_password, custom_params].flatten.join(":")
      when :result
        [@total, @invoice_id, Rubykassa.second_password, custom_params].flatten.join(":")
      when :success
        [@total, @invoice_id, Rubykassa.first_password, custom_params].flatten.join(":")
      end
    end

    def custom_params
      @params.sort.inject([]) do |result, element|
        result << element.join("=") if element[0] =~ /^shp/
        result
      end
    end
  end
end