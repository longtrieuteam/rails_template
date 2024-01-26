# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fullname               :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  otp                    :string
#  password_salt          :string
#  phone                  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'rails_helper'

describe User do
  it { is_expected.to be_kind_of(Utils::I18n) }

  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_presence_of(:fullname) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(20) }

  describe '.ransackable_attributes' do
    it 'returns value' do
      expected = %w[created_at email username fullname phone updated_at password_salt]
      actual = described_class.ransackable_attributes

      expect(actual).to eq(expected)
    end
  end

  describe '#generate_token' do
    let(:user) { build_stubbed(:user) }

    it 'calls Auth::UserJwtToken' do
      expect(Auth::UserJwtToken).to receive(:generate_token_for)
      user.generate_token
    end
  end

  describe '#role_name' do
    context 'when user role is free' do
      let(:user) { build_stubbed(:user) }

      it 'returns free' do
        actual = user.role_name
        expected = 'free'

        expect(actual).to eq(expected)
      end
    end

    context 'when user role is premium' do
      let(:user) { build_stubbed(:user_with_role_premium) }

      it 'returns premium' do
        actual = user.role_name
        expected = 'premium'

        expect(actual).to eq(expected)
      end
    end
  end

  describe '#assign_default_role' do
    context 'when user have no role' do
      before do
        allow(subject).to receive(:roles).and_return(nil)
      end

      it 'calls methods' do
        is_expected.to receive(:add_role).with(:free)

        subject.send(:assign_default_role)
      end
    end

    context 'when user have a role' do
      let(:role) { build_stubbed(:role_free) }

      before do
        allow(subject).to receive(:roles).and_return(role)
      end

      it 'calls methods' do
        is_expected.not_to receive(:add_role).with(any_args)

        subject.send(:assign_default_role)
      end
    end
  end
end
