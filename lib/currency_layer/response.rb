# frozen_string_literal: true

CurrencyLayer::ErrorResponse = Struct.new(:type, :info)

CurrencyLayer::Response = Struct.new(:source, :quotes, :timestamp)
