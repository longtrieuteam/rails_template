# frozen_string_literal: true

require 'rails_helper'

describe Http::Responder do
  let(:response) do
    { code: 200, body: 'valid' }
  end

  subject { described_class.new(response) }

  describe '#code' do
    it 'returns code' do
      expect(subject.code).to eq(200)
    end
  end

  describe '#body' do
    context 'when response is a hash' do
      it 'returns a hash' do
        expect(subject.body).to eq(response)
      end
    end

    context 'when response is not a hash' do
      it 'returns value' do
        expect(described_class.new('value').body).to eq('value')
      end
    end
  end

  describe '#success?' do
    it 'returns true' do
      expect(subject.success?).to eq(true)
    end
  end

  describe '#redirect?' do
    it 'returns false' do
      expect(subject.redirect?).to eq(false)
    end
  end

  describe '#failure?' do
    it 'returns false' do
      expect(subject.failure?).to eq(false)
    end
  end

  describe '#to_h' do
    let(:result) do
      {
        body: { body: 'valid', code: 200 },
        code: 200,
      }
    end

    it 'returns a hash result' do
      expect(subject.to_h).to eq(result)
    end
  end
end
