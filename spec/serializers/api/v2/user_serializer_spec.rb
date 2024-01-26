# frozen_string_literal: true

require 'rails_helper'

describe Api::V2::UserSerializer do
  let(:user) { build_stubbed(:user) }
  let(:actual) { described_class.new(user).serializable_hash[:data] }

  describe '#serializable_hash' do
    attributes = %i[email username fullname phone role]

    it 'returns attributes' do
      expect(actual[:attributes].keys).to match_array(attributes)
    end
  end
end
