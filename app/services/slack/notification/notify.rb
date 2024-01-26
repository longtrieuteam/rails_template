# frozen_string_literal: true

module Slack
  module Notification
    class Notify
      def self.send(message)
        hostname = ENV.fetch('EXCEPTION_HOSTNAME')
        Notifiers::ExceptionWorker.perform_async(message, hostname)
      end
    end
  end
end
