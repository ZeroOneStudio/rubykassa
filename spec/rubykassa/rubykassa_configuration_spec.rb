require 'spec_helper'

describe Rubykassa do
  it "should set configuration information" do
    Rubykassa.configure do |config|
      config.login = "name"
      config.first_password = "first_password"
      config.second_password = "second_password"
    end

    Rubykassa.login.should == "name"    
    Rubykassa.first_password.should == "first_password"
    Rubykassa.second_password.should == "second_password"
  end
end
