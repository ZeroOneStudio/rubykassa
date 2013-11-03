# -*- encoding : utf-8 -*-
require 'rubykassa/signature_generator'

module Rubykassa  
  class PaymentInterface
    include SignatureGenerator

    PARAMS_CONFORMITY = {
      login:       "MrchLogin",
      total:       "OutSum",
      invoice_id:  "InvId",
      signature:   "SignatureValue",
      email:       "Email",
      currency:    "IncCurrLabel",
      description: "Desc",
      culture:     "Culture"
    }

    attr_accessor :invoice_id, :total, :params

    def initialize &block
      instance_eval &block if block_given?
    end

    def test_mode?
      Rubykassa.mode == :test
    end

    def base_url
      test_mode? ? "http://test.robokassa.ru/Index.aspx" : "https://merchant.roboxchange.com/Index.aspx"
    end

    def pay_url(options = {})
      options = options.slice(:currency, :description, :email, :culture)

      "#{base_url}?" + initial_options.merge(options).map do |key, value| 
        "#{PARAMS_CONFORMITY[key.to_sym]}=#{value}" unless key =~ /^shp/
      end.compact!.join("&")
    end

    def initial_options
      {
        login: Rubykassa.login,
        total: @total,
        invoice_id: @invoice_id,
        signature: generate_signature_for(:payment)
      }.merge(Hash[@params.sort.map {|param_name| ["shp#{param_name[0]}".to_sym, param_name[1]]}])
    end
  end
end
