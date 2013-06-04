require 'rubykassa/signature_generator'

module Rubykassa
  class Notification
    include SignatureGenerator

    attr_accessor :params

    def initialize params
      @params = params
      @invoice_id = params["InvId"]
      @total = params["OutSum"]
    end

    %w(payment response success).map do |kind|
      define_method "valid_#{kind}_signature?" do
        @params["SignatureValue"].downcase! == generate_signature_for(kind.to_sym)
      end
    end

    def success
      "OK#{@invoice_id}"
    end
  end
end