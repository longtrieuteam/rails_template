# frozen_string_literal: true

require 'rails_helper'

describe Users::PasswordUpdater do
  include ServiceResponder

  subject { described_class.new({}, resource) }
  let(:user) { create(:user) }
  let(:resource) { user }

  describe '#call' do
    it 'calls methods' do
      expect_any_instance_of(described_class).to receive(:password_updater)

      subject.call
    end
  end

  describe '#password_updater' do
    context 'when update_with_password fail' do
      before do
        allow(resource).to receive(:update_with_password).with({}).and_return(false)
      end

      it 'returns errors' do
        expect(subject.send(:password_updater)).to eq(error(resource))
      end
    end

    context 'when update_with_password success' do
      before do
        allow(resource).to receive(:update_with_password).with({}).and_return(true)
      end

      it 'returns message' do
        expect(subject.send(:password_updater)).to eq(success(resource))
      end
    end
  end
end
