## The Rubykassa gem

[![Gem Version](https://badge.fury.io/rb/rubykassa.png)](http://badge.fury.io/rb/rubykassa)
[![Build Status](https://secure.travis-ci.org/ZeroOneStudio/rubykassa.png)](http://travis-ci.org/ZeroOneStudio/rubykassa)

by [Zero One][]

[Zero One]: http://zeroone.st

Yet another Ruby wrapper for [Robokassa API][]. Rubykassa took the best from [robokassa gem][] and [Active Merchant Robokassa integration] but easier to use and setup.

[Robokassa API]: http://robokassa.ru/ru/Doc/Ru/Interface.aspx
[robokassa gem]: https://github.com/shaggyone/robokassa
[Active Merchant Robokassa integration]: https://github.com/Shopify/active_merchant/tree/master/lib/active_merchant/billing/integrations/robokassa

## Installation

    gem install rubykassa

Or put to your `Gemfile`

    gem "rubykassa"

## Usage

Create an initializer with the following code:

    Rubykassa.configure do |config|
      config.login = "your_login"
      config.first_password = "first_password"
      config.second_password = "second_password"
      config.mode = :test
      config.http_method = :get
      config.xml_http_method = :get
    end

Mode is `:test` by default. For production you have to use `:production`.
`http_method` and `xml_http_method` are `:get` by default but can be configured as `:post`

Once you are done, simple use `pay_url` helper in your view:

    <%= pay_url "Pay with Robokassa", ivoice_id, total_sum %>

Additionally you may want to pass extra options. There is no problem:

    <%= pay_url "Pay with Robokassa", ivoice_id, total_sum, { description: "Invoice description", email: "foo@bar.com", currency: "WMZM", culture: :ru } %>

If you need to implement Robokassa's XML interface functionality you have to the following:

    xml_interface = Rubykassa::XmlInterface.new do
      self.invoice_id = your_invioce_id
      self.total = your_total_sum
      self.language = :ru # can be :en, :ru is default
    end

then call whatever you need

    xml_interface.get_currencies_list
    xml_interface.get_payment_methods
    xml_interface.get_rates
    xml_interface.op_state

## License

This project rocks and uses MIT-LICENSE
Copyright (c) 2013 [Zero One][]

[ZERO.ONE]: http://www.zeroone.st