# frozen_string_literal: true

require 'rails_helper'

describe Users::RoleUpdater do
  include ServiceResponder

  subject { described_class.new(params, user) }
  let(:params) do
    {
      role: 'free',
    }
  end
  let(:user) { create(:user) }

  describe '#call' do
    it 'calls methods' do
      expect_any_instance_of(described_class).to receive(:role_updater)

      subject.call
    end
  end

  describe '#role_updater' do
    context 'when update with invalid role' do
      let('invalid_params') do
        {
          role: 'invalid_role',
        }
      end

      it 'returns errors' do
        actual = described_class.new(invalid_params, user).send(:role_updater)
        expected = {
          success?: false,
          errors: { details: { role: [{ error: 'invalid', value: nil }] },
                    error: 'Role invalid',
                    errors: { role: ['invalid'] }, }.to_json,
        }

        expect(actual.to_json).to eq(expected.to_json)
      end
    end

    context 'when update with valid params' do
      it 'returns messages' do
        expect(subject.send(:role_updater)).to eq(success(user))
      end
    end
  end
end
