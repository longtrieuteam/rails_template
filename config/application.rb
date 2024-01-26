# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'exception_notification'
require 'exception_notification/rails'
require 'exception_notification/sidekiq'

require_relative '../app/middlewares/locale_switcher_middleware'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# https://github.com/bkeepers/dotenv#installation
# Note on load order
Dotenv::Railtie.load

module RailsTemplateBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.time_zone = 'Hanoi'
    config.active_record.default_timezone = :local

    # https://edgeguides.rubyonrails.org/active_job_basics.html#setting-the-backend
    config.active_job.queue_adapter = :sidekiq

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Load class/modules outside of app directory
    preload_paths = ['../lib/core_ext/*.rb'].freeze
    preload_paths.each do |preload_path|
      Dir.glob(File.join(File.dirname(__FILE__), preload_path)).each do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.after_initialize do
      # Load application's model / class decorators
      decorator_paths = ['../app/**/*_decorator*.rb'].freeze
      decorator_paths.each do |decorator_path|
        Dir.glob(File.join(File.dirname(__FILE__), decorator_path)).each do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end
    end

    config.eager_load_paths << config.root.join('lib')

    config.action_view.field_error_proc = proc { |html_tag, _instance|
      "<div class=\"has-danger\">#{html_tag}</div>".html_safe
    }

    # Locale config
    config.i18n.available_locales = %i[en vi]
    config.i18n.default_locale = ENV.fetch('DEFAULT_LOCALE', :en)

    config.middleware.use LocaleSwitcherMiddleware
  end
end
