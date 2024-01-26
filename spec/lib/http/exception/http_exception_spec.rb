# frozen_string_literal: true

require 'rails_helper'

describe Http::Exceptions::HttpException do
  describe '.initialize' do
    context 'with no option' do
      let(:result) { 'An error has occurred while processing response.' }

      it 'returns basic error' do
        expect(described_class.new.to_s).to eq(result)
      end
    end

    context 'with options response' do
      let(:params) do
        { response: { code: 200, body: 'error' } }.to_mash
      end
      let(:result) { "An error has occurred while processing response. Status 200\nerror" }

      it 'returns error with response' do
        expect(described_class.new(params).to_s).to eq(result)
      end
    end

    context 'with original_exception' do
      let(:params) do
        { original_exception: 'exception' }
      end
      let(:result) { 'An error has occurred while processing response. Original Exception: exception' }

      it 'returns error with response' do
        expect(described_class.new(params).to_s).to eq(result)
      end
    end
  end
end
