# frozen_string_literal: true

redis_conn = proc {
  Redis.new(
    url: ENV.fetch('REDIS_URL', nil),
  )
}

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 5, &redis_conn)

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end
end

Sidekiq.configure_server do |config|
  config.logger = Sidekiq::Logger.new($stdout) unless Rails.env.production?
  config.logger.level = Logger::WARN
  config.redis = ConnectionPool.new(size: 30, &redis_conn)

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end

  config.server_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Server
  end

  SidekiqUniqueJobs::Server.configure(config)
end

# https://github.com/reidmorrison/semantic_logger/issues/51#issuecomment-291861691
module Sidekiq
  module Middleware
    module Server
      class TaggedLogging
        SPACE = ' '

        def call(worker, item, _queue) # rubocop:disable Metrics/AbcSize
          logger.tagged(
            klass: log_context(worker, item),
            jid: jid(item),
            queue: queue(item),
            args: args(item),
            created: created(item),
            enqueued: enqueued(item)
          ) do
            start = Time.zone.now
            logger.warn('start')
            yield
            logger.warn("done: #{elapsed(start)} sec")
          rescue Exception
            logger.warn("fail: #{elapsed(start)} sec")
            raise
          end
        end

        private

        # If we're using a wrapper class, like ActiveJob, use the "wrapped"
        # attribute to expose the underlying thing.
        def log_context(worker, item)
          item['wrapped'] || worker.class.to_s
        end

        def jid(item)
          item['jid']
        end

        def queue(item)
          item['queue']
        end

        def args(item)
          item['args'].join(', ')
        end

        def created(item)
          time_at(item['created_at'])
        end

        def enqueued(item)
          time_at(item['enqueued_at'])
        end

        def time_at(time)
          return if time.blank?

          Time.at(time)
        end

        def context
          c = Thread.current[:sidekiq_context]
          " #{c.join(SPACE)}" if c&.any?
        end

        def elapsed(start)
          (Time.zone.now - start).round(3)
        end

        def logger
          Sidekiq.logger
        end
      end
    end
  end
end

if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.server_middleware do |chain|
      chain.add Sidekiq::Middleware::Server::TaggedLogging
    end
  end
end
