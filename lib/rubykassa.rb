require 'rubykassa/engine'
require 'rubykassa/client'
require 'rubykassa/payment_interface'
require 'rubykassa/xml_interface'
require 'rubykassa/notification'

module Rubykassa
  extend self

  def configure(&block)
    Rubykassa::Client.configure &block
  end

  Rubykassa::Configuration::ATTRIBUTES.map do |name|
    define_method name do
      Rubykassa::Client.configuration.send(name)
    end
  end

  def pay_url(invoice_id, total, custom_params, extra_params = {})
    Rubykassa::PaymentInterface.new do
      self.total      = total
      self.invoice_id = invoice_id
      self.params     = custom_params
    end.pay_url(extra_params)
  end
end
