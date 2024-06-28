# frozen_string_literal: true

RSpec.describe CurrencyLayer::ApiConnector do
  subject(:connector) { DummyClass.new }

  describe ".url" do
    before do
      CurrencyLayer.configure do |config|
        config.development = development
      end
    end

    context "with development true" do
      let(:development) { true }

      it { expect(connector.url).to eql "http://api.currencylayer.com/" }
    end

    context "with development false" do
      let(:development) { false }

      it { expect(connector.url).to eql "https://api.currencylayer.com/" }
    end
  end
end
