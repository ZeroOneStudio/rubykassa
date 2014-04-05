# -*- encoding : utf-8 -*-
module Rubykassa
  module ActionViewExtension
    def pay_url phrase, invoice_id, total, options = {}
      total, invoice_id  = total.to_s, invoice_id.to_s
      extra_params  = options.except(:custom)
      custom_params = options[:custom] ||= {}
      link_to phrase, Rubykassa.pay_url(invoice_id, total, custom_params, extra_params)
    end
  end
end