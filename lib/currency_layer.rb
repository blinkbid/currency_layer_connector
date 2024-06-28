# frozen_string_literal: true

require "faraday_connector"
require_relative "currency_layer/api_connector"
require_relative "currency_layer/configuration"
require_relative "currency_layer/live"
require_relative "currency_layer/response"
require_relative "currency_layer/version"

module CurrencyLayer
  class Error < StandardError; end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
