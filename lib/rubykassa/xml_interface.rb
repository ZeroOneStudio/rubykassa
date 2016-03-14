require 'net/http'
require 'multi_xml'
require 'uri'

module Rubykassa
  class InvalidResponseError < StandardError; end

  class XmlInterface
    BASE_URL =
      'https://auth.robokassa.ru/Merchant/WebService/Service.asmx/'.freeze
    INVALID_RESPONSE_ERROR_MESSAGE = 'Invalid response from the service'.freeze

    attr_accessor :invoice_id, :total, :language

    def initialize(&block)
      yield self if block_given?
    end

    def get_currencies
      request transform_method_name(__method__),
              'MerchantLogin' => Rubykassa.login,
              'Language' => @language,
              'isTest' => test_mode_param
    end

    def get_payment_methods
      request transform_method_name(__method__),
              'MerchantLogin' => Rubykassa.login,
              'Language' => @language,
              'isTest' => test_mode_param
    end

    def get_rates
      request transform_method_name(__method__),
              'MerchantLogin' => Rubykassa.login,
              'IncCurrLabel' => '',
              'OutSum' => @total.to_s,
              'Language' => @language,
              'isTest' => test_mode_param
    end

    def op_state(additional_params = {})
      params = { 'MerchantLogin' => Rubykassa.login,
                 'InvoiceID' => @invoice_id.to_s,
                 'Signature' => generate_signature,
                 'isTest' => test_mode_param }
      params.merge! additional_params if test_mode?
      request transform_method_name(__method__), params
    end

    private

    attr_accessor :base_url

    def test_mode?
      Rubykassa.mode == :test
    end

    def test_mode_param
      test_mode? ? 1 : 0
    end

    def generate_signature
      Digest::MD5.hexdigest(
        "#{Rubykassa.login}:#{@invoice_id}:#{Rubykassa.second_password}"
      )
    end

    def transform_method_name(method_name)
      method_name.to_s.split('_').map(&:capitalize).join(' ').gsub(/\s/, '')
    end

    def request(action, params)
      url = BASE_URL.dup << action
      if Rubykassa.xml_http_method == :get
        query = params.map { |key, value| "#{key}=#{value}" }.join '&'
        converted_params = '?' + query
        response = Net::HTTP.get_response URI(url) + converted_params
      else
        response = Net::HTTP.post_form URI(url), params
      end
      unless response.code == '200'
        raise InvalidResponseError, INVALID_RESPONSE_ERROR_MESSAGE
      end
      MultiXml.parse(response.body)
    end
  end
end
