# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Rubykassa::XmlInterface do
  subject do
    described_class.new do |interface|
      interface.invoice_id = invoice_id
      interface.total = total
      interface.language = language
    end
  end

  before(:all) { Rubykassa.configure {} }

  let(:invoice_id) { 12 }
  let(:total) { 12_000 }
  let(:language) { :ru }

  it "sets all passed attributes into initializer block" do
    aggregate_failures do
      expect(subject.invoice_id).to eq(invoice_id)
      expect(subject.total).to eq(total)
      expect(subject.language).to eq(language)
    end
  end

  it "generates correct signature" do
    expect(subject.send(:generate_signature)).to eq("dafff2859f7fd4d110badc476c90fb39")
  end

  it "correctly transforms method name" do
    expect(subject.send(:transform_method_name, "some_method_name")).to eq("SomeMethodName")
  end

  describe "#base_url" do
    subject { described_class.new.base_url }
    context "sets to test URL when in test mode" do
      before { Rubykassa.configure { |c| c.mode = :test } }
      it { is_expected.to eq("http://test.robokassa.ru/Webservice/Service.asmx/") }
    end

    context "uses production URL on production" do
      before { Rubykassa.configure { |c| c.mode = :production } }
      it { is_expected.to eq("https://merchant.roboxchange.com/WebService/Service.asmx/") }
    end
  end

  describe "#op_state" do
    subject { described_class.new.op_state(params) }

    context "depends on mode" do
      let(:params) { { "StateCode" => 5 } }

      before do
        allow(Net::HTTP).to receive(:get_response) do |params|
          OpenStruct.new(code: "200", body: params.to_s)
        end
        allow(MultiXml).to receive(:parse) { |object| object }
      end

      context "accepts additional params with test mode" do
        before { Rubykassa.configure { |c| c.mode = :test } }
        it { is_expected.to eq("http://test.robokassa.ru/Webservice/Service.asmx/OpState?MerchantLogin=your_login&InvoiceID=&Signature=7b7d63d7d72c05ee8470f467bda8adf1&StateCode=5") }
      end

      context "ignores additional params with production mode" do
        before { Rubykassa.configure { |c| c.mode = :production } }
        it { is_expected.to eq("https://merchant.roboxchange.com/WebService/Service.asmx/OpState?MerchantLogin=your_login&InvoiceID=&Signature=7b7d63d7d72c05ee8470f467bda8adf1") }
      end
    end
  end
end
