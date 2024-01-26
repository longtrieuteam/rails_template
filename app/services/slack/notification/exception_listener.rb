# frozen_string_literal: true

module Slack
  module Notification
    class ExceptionListener < Base
      private

      def webhook_url
        ENV.fetch('EXCEPTION_NOTIFICATION_SLACK_WEBHOOK_URL')
      end

      def channel
        "##{ENV.fetch('EXCEPTION_NOTIFICATION_SLACK_CHANNEL')}"
      end
    end
  end
end
