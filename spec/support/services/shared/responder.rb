# frozen_string_literal: true

require 'rails_helper'

shared_examples 'returns service responder success format' do
  it 'returns success? is true' do
    expect(result.success?).to eq(true)
  end

  it 'returns resource is resource' do
    expect(result.resource).to eq(resource)
  end
end

shared_examples 'returns service responder error format' do
  it 'returns success? is false' do
    expect(result.success?).to eq(false)
  end

  it 'returns resource is resource' do
    expect(result.resource).to eq(resource)
  end

  it 'returns field errors' do
    expect(result.respond_to?(:errors)).to eq(true)
  end
end
