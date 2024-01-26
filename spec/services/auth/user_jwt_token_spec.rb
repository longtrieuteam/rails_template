# frozen_string_literal: true

require 'rails_helper'

describe Auth::UserJwtToken do
  let(:user) { create(:user) }
  let(:user_jwt_token) { described_class.generate_token_for(user) }

  describe '.generate_token_for' do
    it 'returns token' do
      expect(user_jwt_token[:token]).not_to be_blank
    end

    it 'returns role' do
      actual = user_jwt_token[:role]
      expected = 'free'

      expect(actual).to eq(expected)
    end
  end

  describe '.user_from_token' do
    context 'with valid token' do
      it 'returns user' do
        actual = described_class.user_from_token(user_jwt_token[:token])

        expect(actual.to_json).to eq(user.to_json)
      end
    end

    context 'with invalid token' do
      it 'returns nil' do
        expect(described_class.user_from_token('invalid_token')).to be_nil
      end
    end
  end
end
