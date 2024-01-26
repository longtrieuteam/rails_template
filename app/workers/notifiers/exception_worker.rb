# frozen_string_literal: true

module Notifiers
  class ExceptionWorker < ApplicationWorker
    sidekiq_options queue: :exception_notifier

    def perform(message, hostname)
      exception = Exception.new(message)
      extra_config = { hostname: }
      ExceptionNotifier.notify_exception(
        exception,
        Slack::Notification::ExceptionListener.configuration(extra_config:),
      )
    end
  end
end
