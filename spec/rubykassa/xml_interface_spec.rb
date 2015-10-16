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

  let(:invoice_id) { 12 }
  let(:total) { 12_000 }
  let(:language) { :ru }

  it "sets all passed attributes into initializer block" do
    expect(subject.invoice_id).to eq(invoice_id)
    expect(subject.total).to eq(total)
    expect(subject.language).to eq(language)
  end

  it "returns correct base_url" do
    expect(subject.base_url).to eq("https://merchant.roboxchange.com/WebService/Service.asmx/")
  end

  it "generates correct signature" do
    expect(subject.send(:generate_signature)).to eq("dafff2859f7fd4d110badc476c90fb39")
  end

  it "correctly transforms method name" do
    expect(subject.send(:transform_method_name, "some_method_name")).to eq("SomeMethodName")
  end
end
