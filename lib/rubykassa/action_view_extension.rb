# -*- encoding : utf-8 -*-
module Rubykassa
  module ActionViewExtension
    def pay_url(phrase = nil, invoice_id = nil, total = nil, options = {}, &block)
      invoice_id, total = phrase, invoice_id if block_given?
      total, invoice_id  = total.to_s, invoice_id.to_s

      extra_params  = options.except([:custom, :html])
      custom_params = options[:custom] ||= {}
      html_params = options[:html] ||= {}

      if block_given?
        link_to Rubykassa.pay_url(invoice_id, total, custom_params, extra_params), html_params, &block
      else
        link_to phrase, Rubykassa.pay_url(invoice_id, total, custom_params, extra_params), html_params
      end
      
    end
  end
end
