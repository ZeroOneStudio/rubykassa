require 'spec_helper'

describe Rubykassa::Client do
  before(:each) do
    Rubykassa.configure do |config|
      config.login = 'name'
      config.first_password = 'first_password'
      config.second_password = 'second_password'
      config.mode = :production
      config.http_method = :post
      config.xml_http_method = :post
    end
  end

  it 'should set configuration information correctly' do
    expect(Rubykassa.login).to eq 'name'
    expect(Rubykassa.first_password).to eq 'first_password'
    expect(Rubykassa.second_password).to eq 'second_password'
    expect(Rubykassa.mode).to eq :production
    expect(Rubykassa.http_method).to eq :post
    expect(Rubykassa.xml_http_method).to eq :post
  end

  it 'should set default values' do
    Rubykassa.configure do; end

    expect(Rubykassa.login).to eq 'your_login'
    expect(Rubykassa.first_password).to eq 'first_password'
    expect(Rubykassa.second_password).to eq 'second_password'
    expect(Rubykassa.mode).to eq :test
    expect(Rubykassa.http_method).to eq :get
    expect(Rubykassa.http_method).to eq :get
    expect(Rubykassa.success_callback).to be_instance_of(Proc)
    expect(Rubykassa.fail_callback).to be_instance_of(Proc)
  end

  it 'should set success_callback' do
    Rubykassa.configure do |config|
      config.success_callback = -> { 2 + 5 }
    end
    expect(Rubykassa.success_callback.call).to eq(7)
  end

  it 'should raise error when wrong mode is set' do
    expect {
      Rubykassa.configure do |config|
        config.mode = :bullshit
      end
    }.to raise_error(Rubykassa::ConfigurationError,
                     Rubykassa::ConfigurationError::ENV_MESSAGE)
  end

  it 'should raise error when wrong http_method is set' do
    expect {
      Rubykassa.configure do |config|
        config.http_method = :bullshit
      end
    }.to raise_error(Rubykassa::ConfigurationError,
                     Rubykassa::ConfigurationError::HTTP_METHOD_MESSAGE)
  end

  it 'should raise error when wrong xml_http_method is set' do
    expect {
      Rubykassa.configure do |config|
        config.xml_http_method = :bullshit
      end
    }.to raise_error(Rubykassa::ConfigurationError,
                     Rubykassa::ConfigurationError::HTTP_METHOD_MESSAGE)
  end
end
