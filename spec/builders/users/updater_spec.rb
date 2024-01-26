# frozen_string_literal: true

require 'rails_helper'

describe Users::Updater do
  include ServiceResponder

  subject { described_class.new({ fullanme: 'fullname' }, resource) }
  let(:user) { create(:user) }
  let(:resource) { user }

  describe '#call' do
    it 'calls methods' do
      expect_any_instance_of(described_class).to receive(:user_updater)

      subject.call
    end
  end

  describe '#user_updater' do
    context 'when update_columns fail' do
      before do
        allow(resource).to receive(:update_columns).with({ fullanme: 'fullname' }).and_return(false)
      end

      it 'returns errors' do
        expect(subject.send(:user_updater)).to eq(error(resource))
      end
    end

    context 'when update_columns success' do
      before do
        allow(resource).to receive(:update_columns).with({ fullanme: 'fullname' }).and_return(true)
      end

      it 'returns message' do
        expect(subject.send(:user_updater)).to eq(success(resource))
      end
    end
  end
end
