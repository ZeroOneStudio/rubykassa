module Rubykassa
  module SignatureGenerator
    KIND_ERROR_MESSAGE =
      'Available kinds are only :payment, :result or :success'.freeze

    def generate_signature_for(kind)
      unless [:success, :payment, :result].include?(kind)
        raise ArgumentError, KIND_ERROR_MESSAGE
      end
      Digest::MD5.hexdigest(params_string(kind))
    end

    def params_string kind
      result = case kind
               when :payment
                 [Rubykassa.login, @total, @invoice_id,
                  Rubykassa.first_password, custom_params]
               when :result
                 [@total, @invoice_id, Rubykassa.second_password, custom_params]
               when :success
                 [@total, @invoice_id, Rubykassa.first_password, custom_params]
               end
      result.flatten.join ':'
    end

    def custom_params
      @params.sort.inject([]) do |result, element|
        result << element.join('=') if element[0] =~ /^shp/
        result
      end
    end
  end
end
