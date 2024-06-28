# frozen_string_literal: true

module CurrencyLayer
  module ApiConnector
    include FaradayConnector

    def url
      protocol = CurrencyLayer.configuration.development ? "http" : "https"
      "#{protocol}://api.currencylayer.com/"
    end

    def auth
    end
  end
end
