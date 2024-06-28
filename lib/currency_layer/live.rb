# frozen_string_literal: true

module CurrencyLayer
  class Live
    include ApiConnector

    def initialize(source:, currencies: [])
      @source = source
      @currencies = currencies
    end

    protected

    def do_request
      get(
        "/live",
        {
          access_key: CurrencyLayer.configuration.access_key,
          currencies: @currencies.join(","),
          source: @source
        }
      )
    end

    def do_process
      value = request.value!
      body = value.body

      return build_error_response(body) unless body.fetch("success", false)

      build_response(body)
    end

    def build_error_response(body)
      [
        :error,
        ErrorResponse.new(
          type: body.dig("error", "type").to_sym,
          info: body.dig("error", "info")
        )
      ]
    end

    def build_response(body)
      [
        :ok,
        Response.new(
          quotes: body.fetch("quotes"),
          source: body.fetch("source"),
          timestamp: body.fetch("timestamp")
        )
      ]
    end
  end
end
