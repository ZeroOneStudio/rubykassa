# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Rubykassa::PaymentInterface do
  before(:each) do
    @payment_interface = Rubykassa::PaymentInterface.new do
      self.invoice_id = 12
      self.total = 1200
      self.params = {foo: "bar"}
    end

    Rubykassa.configure do |config|
    end
  end

  it "should return correct base_url" do
    @payment_interface.base_url.should == "http://test.robokassa.ru/Index.aspx"
  end

  it "should return correct pay_url" do
    @payment_interface.pay_url.should == "http://test.robokassa.ru/Index.aspx?MrchLogin=your_login&OutSum=1200&InvId=12&SignatureValue=96c0bbd4fc8f365455e949b1fbf5e3f4"
  end

  it "should return correct pay_url when additional options passed" do
    @payment_interface.pay_url({description: "desc", culture: "ru", email: "foo@bar.com", currency: ""}).should == "http://test.robokassa.ru/Index.aspx?MrchLogin=your_login&OutSum=1200&InvId=12&SignatureValue=96c0bbd4fc8f365455e949b1fbf5e3f4&IncCurrLabel=&Desc=desc&Email=foo@bar.com&Culture=ru"
  end

  it "should return correct initial_options" do
    @payment_interface.initial_options.should == {
      login: "your_login",
      total: 1200,
      invoice_id: 12,
      signature: "96c0bbd4fc8f365455e949b1fbf5e3f4",
      shpfoo: "bar"
    }
  end

  it "should return correct test_mode?" do
    @payment_interface.test_mode?.should == true
  end
end
