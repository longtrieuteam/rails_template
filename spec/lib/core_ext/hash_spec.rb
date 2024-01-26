# frozen_string_literal: true

require 'rails_helper'

describe CoreExt::Hash do
  let(:hash) do
    {
      key: :value,
    }
  end

  describe '#to_mash' do
    it 'returns instance of Hashie::Mash' do
      actual = hash.to_mash
      expected = HashieMashResult.new(hash)

      expect(actual).to eq(expected)
    end
  end
end
