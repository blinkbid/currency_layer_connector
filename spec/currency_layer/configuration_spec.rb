# frozen_string_literal: true

RSpec.describe CurrencyLayer::Configuration do
  subject(:configuration) { described_class.new }

  it "development has default value" do
    expect(configuration.development).to be_falsy
  end
end
