require 'rubykassa/signature_generator'

module Rubykassa
  class Notification
    include SignatureGenerator

    attr_accessor :params

    def initialize params
      @params = params
    end

    def invoice_id
      @invoice_id = @params["InvId"]
    end

    def total
      @total = @params["OutSum"]
    end

    %w(payment response).map do |kind|
      define_method "valid_#{kind}_signature?" do
        @params["SignatureValue"] == generate_signature_for(kind.to_sym)
      end
    end

    def success
      "OK#{@invoice_id}"
    end
  end
end