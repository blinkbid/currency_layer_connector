# frozen_string_literal: true

RSpec.describe CurrencyLayer do
  it "has a version number" do
    expect(CurrencyLayer::VERSION).not_to be nil
  end

  it "has a configuration" do
    expect(CurrencyLayer.configuration).to be_instance_of CurrencyLayer::Configuration
  end

  describe ".configure" do
    let(:access_key) { "secret" }

    before do
      CurrencyLayer.configure do |config|
        config.access_key = "secret"
        config.development = true
      end
    end

    it "sets api_key" do
      expect(CurrencyLayer.configuration.access_key).to eql access_key
    end

    it "sets development mode" do
      expect(CurrencyLayer.configuration.development).to be_truthy
    end
  end
end
