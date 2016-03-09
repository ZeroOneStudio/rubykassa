require 'spec_helper'

describe Rubykassa::Notification do
  it 'should return correct valid_result_signature?' do
    params = { 'InvId' => '12',
               'OutSum' => '1200',
               'SignatureValue' => '373641e09a9d203ffa8639074c8e9697' }
    notification = Rubykassa::Notification.new params
    expect(notification.valid_result_signature?).to be_truthy
  end

  it 'should return correct valid_success_signature?' do
    params = { 'InvId' => '12',
               'OutSum' => '1200',
               'SignatureValue' => '9f219cd519aa7bd3549065b613a13a52' }
    notification = Rubykassa::Notification.new params
    expect(notification.valid_success_signature?).to be_truthy
  end

  it 'should return correct success' do
    notification = Rubykassa::Notification.new Hash 'InvId' => '12'
    expect(notification.success).to eq 'OK12'
  end

  context 'signature generator' do
    it 'should raise error in case of wrong kind of argument' do
      expect {
        notification = Rubykassa::Notification.new
        notification.generate_signature_for :bullshit
      }.to raise_error(ArgumentError,
                       Rubykassa::SignatureGenerator::KIND_ERROR_MESSAGE)
    end
  end
end
