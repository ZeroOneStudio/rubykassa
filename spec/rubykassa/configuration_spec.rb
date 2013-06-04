require 'spec_helper'

describe Rubykassa do
  before(:each) do
    Rubykassa.configure do |config|
      config.login = "name"
      config.first_password = "first_password"
      config.second_password = "second_password"
      config.mode = :production
     config.http_method = :post
    end
  end

  it "should set configuration information correctly" do
    Rubykassa.login.should == "name"    
    Rubykassa.first_password.should == "first_password"
    Rubykassa.second_password.should == "second_password"
    Rubykassa.mode.should == :production
    Rubykassa.http_method.should == :post
  end

  it "should set default values" do
    Rubykassa.configure do |config|
    end

    Rubykassa.login.should == "your_login"    
    Rubykassa.first_password.should == "first_password"
    Rubykassa.second_password.should == "second_password"
    Rubykassa.mode.should == :test
    Rubykassa.http_method.should == :get
  end

  it "should raise error when wrong mode is set" do
    expect {     
      Rubykassa.configure do |config|
        config.mode = :bullshit
      end 
    }.to raise_error(Rubykassa::ConfigurationError, "Alailable modes are :test or :production")
  end

  it "should raise error when wrong http_method is set" do
    expect {     
      Rubykassa.configure do |config|
        config.http_method = :bullshit
      end 
    }.to raise_error(Rubykassa::ConfigurationError, "Alailable http methods are :get or :post")
  end
end
