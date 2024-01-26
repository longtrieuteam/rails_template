# frozen_string_literal: true

require 'rails_helper'

describe Api::V2::UsersPolicy do
  describe 'for a free user' do
    let(:user) { build_stubbed(:user) }
    subject { described_class.new(user, User.new) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to permit_action(:update_info) }
    it { is_expected.to permit_action(:update_password) }
    it { is_expected.to permit_action(:update_role) }
    it { is_expected.to permit_action(:forgot_password) }
    it { is_expected.to permit_action(:reset_password) }
  end

  describe 'for a premium user' do
    let(:user) { build_stubbed(:user_with_role_premium) }
    subject { described_class.new(user, User.new) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to permit_action(:update_info) }
    it { is_expected.to permit_action(:update_password) }
    it { is_expected.to permit_action(:update_role) }
    it { is_expected.to permit_action(:forgot_password) }
    it { is_expected.to permit_action(:reset_password) }
  end
end
