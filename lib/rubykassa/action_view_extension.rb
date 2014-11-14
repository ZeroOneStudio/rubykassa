# -*- encoding : utf-8 -*-
module Rubykassa
  module ActionViewExtension
    def pay_url phrase = nil, invoice_id, total, options = {}, &block
      total, invoice_id  = total.to_s, invoice_id.to_s
      extra_params  = options.except([:custom, :html])
      custom_params = options[:custom] ||= {}
      html_params = options[:html] ||= {}
      link_to phrase, Rubykassa.pay_url(invoice_id, total, custom_params, extra_params), html_params, &block
    end
  end
end
