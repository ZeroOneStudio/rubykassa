# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Rubykassa::XmlInterface do
  before(:each) do
    @xml_interface = Rubykassa::XmlInterface.new do
      self.invoice_id = 12
      self.total = 1200
      self.language =:ru
    end

    Rubykassa.configure do |config|
    end
  end

  it "should return correct base_url" do
    @xml_interface.base_url.should == "https://merchant.roboxchange.com/WebService/Service.asmx/"
  end

  it "should generate correct signature" do
    @xml_interface.send(:generate_signature).should == "dafff2859f7fd4d110badc476c90fb39"
  end

  it "should correctly transform method name" do
    @xml_interface.send(:transform_method_name, "some_method_name").should == "SomeMethodName"
  end
end
