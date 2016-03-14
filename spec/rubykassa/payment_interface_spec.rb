require 'spec_helper'

describe Rubykassa::PaymentInterface do
  before(:each) do
    @payment_interface = Rubykassa::PaymentInterface.new do
      self.invoice_id = 12
      self.total = 1200
      self.params = { foo: 'bar' }
    end
  end

  it 'should return correct pay_url' do
    expect(@payment_interface.pay_url).to eq 'https://auth.robokassa.ru/Merchant/Index.aspx?MerchantLogin=your_login&OutSum=1200&InvId=12&IsTest=1&SignatureValue=bf0504363d89638669e057932857316c&shpfoo=bar'
  end

  it 'should return correct pay_url when additional options passed' do
    url = @payment_interface.pay_url description: 'desc',
                                     culture: 'ru',
                                     email: 'foo@bar.com',
                                     currency: ''
    expect(url).to eq 'https://auth.robokassa.ru/Merchant/Index.aspx?MerchantLogin=your_login&OutSum=1200&InvId=12&IsTest=1&SignatureValue=bf0504363d89638669e057932857316c&shpfoo=bar&IncCurrLabel=&Desc=desc&Email=foo@bar.com&Culture=ru'
  end

  it 'should return correct initial_options' do
    params = { login: 'your_login',
               total: 1200,
               invoice_id: 12,
               signature: 'bf0504363d89638669e057932857316c',
               shpfoo: 'bar',
               is_test: 1 }
    expect(@payment_interface.initial_options).to eq(params)
  end

  it 'should return correct test_mode?' do
    expect(@payment_interface.test_mode?).to be_truthy
  end
end
