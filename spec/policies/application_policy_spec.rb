# frozen_string_literal: true

require 'rails_helper'
require 'pundit/rspec'

describe ApplicationPolicy do
  let(:user) { build_stubbed(:user) }
  let(:scope_subject) { ApplicationPolicy::Scope.new(user, double('double')) }
  subject { described_class.new(user, double('double')) }

  it { is_expected.to forbid_action(:index) }
  it { is_expected.to forbid_action(:show) }
  it { is_expected.to forbid_action(:new) }
  it { is_expected.to forbid_action(:update) }
  it { is_expected.to forbid_action(:edit) }
  it { is_expected.to forbid_action(:destroy) }

  describe '#resolve' do
    it 'raises exception' do
      expect do
        scope_subject.resolve
      end.to raise_exception(NotImplementedError, 'You must define #resolve in ApplicationPolicy::Scope')
    end
  end
end
