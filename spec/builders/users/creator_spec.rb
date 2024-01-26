# frozen_string_literal: true

require 'rails_helper'

describe Users::Creator do
  include ServiceResponder

  subject { described_class.new(params) }
  let(:params) { attributes_for :user }

  describe '#call' do
    it 'calls methods' do
      expect_any_instance_of(described_class).to receive(:user_creator)

      subject.call
    end
  end

  describe '#user_creator' do
    context 'when password and password_confirm are different' do
      let(:invalid_params) do
        {
          username: params['username'],
          email: params['email'],
          password: 'user_password',
          password_confirmation: 'password_confirmation',
        }
      end

      it 'returns errors' do
        expected = {
          success?: false,
          errors: { details: { password_or_password_confirmation: [{ error: 'invalid', value: nil }] },
                    error: 'Password Or Password Confirmation invalid',
                    errors: { password_or_password_confirmation: ['invalid'] }, }.to_json,
        }
        actual = described_class.new(invalid_params).send(:user_creator)

        expect(actual.to_json).to eq(expected.to_json)
      end
    end

    context 'when create with invalid params' do
      let(:invalid_params) { {} }

      it 'returns errors' do
        actual = described_class.new(invalid_params).send(:user_creator).success?
        expected = false

        expect(actual).to eq(expected)
      end
    end

    context 'when create with valid params' do
      let(:valid_params) do
        params.merge({ password_confirmation: params[:password] })
      end

      it 'returns success' do
        actual = described_class.new(valid_params).send(:user_creator).success?
        expected = true

        expect(actual).to eq(expected)
      end
    end
  end
end
