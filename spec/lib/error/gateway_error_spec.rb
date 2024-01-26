# frozen_string_literal: true

require 'rails_helper'

describe Error::GatewayError do
  it 'inherits RuntimeError' do
    expect(described_class.new).to be_a(RuntimeError)
  end
end
