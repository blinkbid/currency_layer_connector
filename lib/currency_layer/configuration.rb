# frozen_string_literal: true

module CurrencyLayer
  class Configuration
    attr_accessor :access_key, :development

    def initialize
      @development = false
    end
  end
end
