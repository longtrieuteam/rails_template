# frozen_string_literal: true

require 'rails_helper'

describe Slack::Notification::Notify do
  it 'calls methods' do
    expect(Notifiers::ExceptionWorker).to receive(:perform_async).with('message', ENV.fetch('EXCEPTION_HOSTNAME'))

    described_class.send('message')
  end
end
