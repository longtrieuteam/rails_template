# frozen_string_literal: true

module Slack
  module Notification
    class Base
      class << self
        def notify(message)
          new.notifier.ping(message)
        end

        def configuration(extra_config: {})
          new.configuration.merge(extra_config)
        end
      end

      def configuration
        {
          webhook_url:,
          channel:,
        }
      end

      def notifier
        @notifier ||= Slack::Notifier.new(webhook_url, channel:)
      end
    end
  end
end
