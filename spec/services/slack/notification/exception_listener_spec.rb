# frozen_string_literal: true

require 'rails_helper'

describe Slack::Notification::ExceptionListener do
  let(:exception_listener) { described_class.new }

  describe '#webhook_url' do
    it 'returns ENV variable' do
      expect(exception_listener.send(:webhook_url)).not_to be_blank
    end
  end

  describe '#channel' do
    it 'returns ENV variable' do
      expect(exception_listener.send(:channel)).not_to be_blank
    end
  end
end
