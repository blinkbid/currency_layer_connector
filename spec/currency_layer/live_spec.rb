# frozen_string_literal: true

RSpec.describe CurrencyLayer::Live do
  subject(:live) { described_class.new(source: source, currencies: currencies) }

  let(:source) { "USD" }
  let(:currencies) { ["BRL", "EUR"] }

  before { CurrencyLayer.configuration.access_key = "secret" }

  describe "/live request" do
    context "without access key" do
      let(:response) do
        {
          sucess: false,
          error: {
            type: "missing_access_key",
          }
        }
      end

      before do
        CurrencyLayer.configuration.access_key = nil
        stub_request(:get, "https://api.currencylayer.com/live?access_key&currencies=BRL,EUR&source=USD")
          .to_return(status: 200, body: response.to_json, headers: {"Content-Type": "application/json"})

          @result, @response = live.process
      end

      it { expect(@result).to eql :error }

      it { expect(@response.type).to eql :missing_access_key }
    end

    context "with right params" do
      let(:currencies) { ["BRL", "EUR"] }
      let(:source) { "USD" }
      let(:response) do
        {
          success: true,
          quotes: {
            USDBRL: 5.366402
          },
          source: source,
          timestamp: "1718141283"
        }
      end

      before do
        stub_request(:get, "https://api.currencylayer.com/live?access_key=secret&currencies=BRL,EUR&source=USD")
          .to_return(status: 200, body: response.to_json, headers: {"Content-Type": "application/json"})

        @result, @response = live.process
      end

      it { expect(@result).to eql :ok }

      it { expect(@response.source).to eql(source) }

      it { expect(@response.quotes).to have_key("USDBRL") }
    end
  end
end
