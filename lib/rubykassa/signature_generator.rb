module Rubykassa
  module SignatureGenerator
    KIND_ERROR_MESSAGE =
      'Available kinds are only :payment, :result or :success'.freeze

    def generate_signature_for(kind)
      unless [:success, :payment, :result].include?(kind)
        raise ArgumentError, KIND_ERROR_MESSAGE
      end
      method(Rubykassa.hash_algorithm).call params_string(kind)
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

    protected

    def md5(data)
      Digest::MD5.hexdigest data
    end

    def ripemd160(data)
      Digest::RMD160.hexdigest data
    end

    def sha1(data)
      Digest::SHA1.hexdigest data
    end

    def sha265(data)
      Digest::SHA256.hexdigest data
    end

    def sha384(data)
      Digest::SHA384.hexdigest data
    end

    def sha512(data)
      Digest::SHA512.hexdigest data
    end
  end
end
