require 'rubykassa/signature_generator'

module Rubykassa
  class PaymentInterface
    include SignatureGenerator

    BASE_URL = 'https://auth.robokassa.ru/Merchant/Index.aspx'.freeze
    PARAMS_CONFORMITY = {
      login:       'MerchantLogin'.freeze,
      total:       'OutSum'.freeze,
      invoice_id:  'InvId'.freeze,
      signature:   'SignatureValue'.freeze,
      email:       'Email'.freeze,
      currency:    'IncCurrLabel'.freeze,
      description: 'Desc'.freeze,
      culture:     'Culture'.freeze,
      is_test:     'IsTest'.freeze
    }.freeze

    attr_accessor :invoice_id, :total, :params

    def initialize(&block)
      instance_eval &block if block_given?
      shpfy_params
    end

    def test_mode?
      Rubykassa.mode == :test
    end

    def pay_url(extra_params = {})
      extra_params = extra_params.slice :currency, :description, :email,
                                        :culture
      result_params = initial_options.merge(extra_params).map do |key, value|
        if key =~ /^shp/
          "#{key}=#{value}"
        else
          "#{PARAMS_CONFORMITY[key]}=#{value}"
        end
      end
      BASE_URL.dup << '?' << result_params.compact.join('&')
    end

    def initial_options
      result = {
        login: Rubykassa.login,
        total: @total,
        invoice_id: @invoice_id,
        is_test: test_mode? ? 1 : 0,
        signature: generate_signature_for(:payment)
      }
      custom_params = @params.sort.map { |param_name| param_name.first 2 }
      result.merge Hash[custom_params]
    end

    private

    def shpfy_params
      @params = @params.map do |param_name|
        # REFACTOR: #to_sym on params-based strings will cause memory bloat on Ruby prior to 2.2
        ["shp#{param_name[0]}".to_sym, param_name[1]]
      end
    end
  end
end
