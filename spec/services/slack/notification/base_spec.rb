# frozen_string_literal: true

require 'rails_helper'

class DummyExceptionListener < Slack::Notification::Base
  def webhook_url
    'https://hooks.slack.com'
  end

  def channel
    'channel'
  end

  def ping(message)
    message
  end
end

describe Slack::Notification::Base do
  describe '.notify' do
    let(:dummy_exception_listener) { DummyExceptionListener.new }

    before do
      allow(Slack::Notifier).to receive(:new).and_return(dummy_exception_listener)
    end

    it 'returns ENV variable' do
      expect(DummyExceptionListener.notify('message')).to eq('message')
    end
  end

  describe '.configuration' do
    let(:result) do
      { channel: 'channel', key: 'value', webhook_url: 'https://hooks.slack.com' }
    end

    it 'returns ENV variable' do
      expect(DummyExceptionListener.configuration(extra_config: { key: 'value' })).to eq(result)
    end
  end
end
