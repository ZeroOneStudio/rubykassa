# -*- encoding : utf-8 -*-
require 'net/http'
require 'multi_xml'
require 'uri'

module Rubykassa
  class InvalidResponseError < StandardError; end

  class XmlInterface
    attr_accessor :invoice_id, :total, :language

    def initialize &block
      instance_eval &block if block_given?
    end

    def get_currencies
      request(base_url + transform_method_name(__method__), Hash["MerchantLogin", Rubykassa.login, "Language", @language])
    end

    def get_payment_methods
      request(base_url + transform_method_name(__method__), Hash["MerchantLogin", Rubykassa.login, "Language", @language])
    end

    def get_rates
      request(base_url + transform_method_name(__method__), Hash["MerchantLogin", Rubykassa.login, "IncCurrLabel", "", "OutSum", @total.to_s, "Language", @language])
    end

    def op_state
      request(base_url + transform_method_name(__method__), Hash["MerchantLogin", Rubykassa.login, "InvoiceID", @invoice_id.to_s, "Signature", generate_signature])
    end

    def base_url
      "https://merchant.roboxchange.com/WebService/Service.asmx/"
    end

    private

    def generate_signature
      Digest::MD5.hexdigest("#{Rubykassa.login}:#{@invoice_id}:#{Rubykassa.second_password}")
    end

    def transform_method_name meth
      meth.to_s.split('_').map(&:capitalize).join(' ').gsub(/\s/, "")
    end  

    def request url, params
      if Rubykassa.xml_http_method == :get
        converted_params = "?" + params.map {|key, value| "#{key}=#{value}" }.join("&")
        response = Net::HTTP.get_response(URI(url) + converted_params)
      else
        response = Net::HTTP.post_form(URI(url), params)
      end
      raise InvalidResponseError, "Invalid response from the service" unless response.code == "200"
      MultiXml.parse(response.body)
    end
  end
end