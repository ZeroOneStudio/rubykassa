# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Rubykassa::Notification do
  before(:each) do
    Rubykassa.configure do |config|
    end
  end

  it "should return correct valid_result_signature?" do
    notification = Rubykassa::Notification.new(Hash["InvId", "12", "OutSum", "1200", "SignatureValue", "373641e09a9d203ffa8639074c8e9697"])
    notification.valid_result_signature?.should == true
  end

  it "should return correct valid_success_signature?" do
    notification = Rubykassa::Notification.new(Hash["InvId", "12", "OutSum", "1200", "SignatureValue", "9f219cd519aa7bd3549065b613a13a52"])
    notification.valid_success_signature?.should == true
  end

  it "should return correct success" do
    notification = Rubykassa::Notification.new(Hash["InvId", "12"])
    notification.success.should == "OK12"
  end

  it "should raise error when wrong kind argument is passed to signature generator" do
    expect {     
      notification = Rubykassa::Notification.new({})
      notification.generate_signature_for(:bullshit)
    }.to raise_error(ArgumentError, "Available kinds are only :payment, :result or :success")
  end
end
