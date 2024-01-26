# frozen_string_literal: true

require 'rails_helper'

describe ServiceResponder do
  class DummyServiceResponderClass # rubocop:disable Lint/ConstantDefinitionInBlock
    include ServiceResponder

    def call_success(resource)
      success(resource)
    end

    def call_error(resource)
      error(resource)
    end
  end

  let(:dummy_class) { DummyServiceResponderClass.new }
  let(:resource) { build_stubbed(:user) }
  let(:success) { dummy_class.call_success(resource) }
  let(:error) { dummy_class.call_error(resource) }

  describe '#success' do
    it 'returns attribute success? is true' do
      expect(success.success?).to eq(true)
    end

    it 'returns attribute resource is resource' do
      expect(success.resource).to eq(resource)
    end
  end

  describe '#error' do
    let(:error_messages) { { field_name: 'Message' } }

    before do
      allow(resource).to receive_message_chain(:errors).and_return(error_messages)
    end

    it 'returns attribute success? is false' do
      expect(error.success?).to eq(false)
    end

    it 'returns attribute resource is resource' do
      expect(error.resource).to eq(resource)
    end

    it 'returns attribute errors is active model errors' do
      expect(error.errors).to eq(error_messages)
    end
  end
end
