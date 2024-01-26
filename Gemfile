# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.2'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails', '~> 3.4'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails', '~> 1.2'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails', '~> 1.4'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails', '~> 1.2'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.16', require: false

# Use Sass to process CSS
gem 'sassc-rails', '~> 2.1'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.12'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 2.0'

# Autoload dotenv in Rails
gem 'dotenv-rails', '~> 2.7'

# Hashie is a collection of classes and mixins that make hashes more powerful.
gem 'hashie', '~> 5.0'

# A fast JSON:API serializer for Ruby Objects.
gem 'jsonapi-serializer', '~> 2.2'

# Makes http request
gem 'httparty', '~> 0.20'

# Flexible authentication solution for Rails with Warden
gem 'devise', '~> 4.9'

# Devise encryptable behavior since v2.1
gem 'devise-encryptable', '~> 0.2'

# A ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard.
gem 'jwt', '~> 2.7'

# HTML Abstraction Markup Language - A Markup Haiku
gem 'haml', '~> 6.1'

# Object-based searching.
gem 'ransack', '~> 4.0'

# Attributes on Steroids for Plain Old Ruby Objects
gem 'virtus', '~> 2.0'

# Simple, efficient background processing for Ruby.
gem 'sidekiq', '~> 6.5'

# Prevents duplicate Sidekiq jobs
gem 'sidekiq-unique-jobs', '~> 7.1'

# Cron jobs in Ruby
gem 'whenever', '~> 1.0', require: false

# Role management library with resource scoping
gem 'rolify', '~> 6.0'

# Minimal authorization through OO design and pure Ruby classes
gem 'pundit', '~> 2.3'

# The official AWS SDK for Ruby.
gem 'aws-sdk-s3', '~> 1.131'

# A simple wrapper for posting to slack channels
gem 'slack-notifier', '~> 2.4'

# Exception Notifier Plugin for Rails
gem 'exception_notification', '~> 4.5'

# The administration framework for Ruby on Rails applications.
gem 'activeadmin', '~> 3.0'

# acts_as_paranoid for Rails 5, 6 and 7
gem 'paranoia', '~> 2.6'

# # A Ruby Library for dealing with money and currency conversion.
gem 'money', '~> 6.16'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', '~> 1.8', platforms: %i[mri mingw x64_mingw]

  gem 'pry-byebug', '~> 3.10'
  # Use Pry as your rails console
  gem 'pry-rails', '~> 0.3'
  # Pretty print Ruby objects to visualize their structure
  gem 'awesome_print', '~> 1.9', require: 'ap'

  # RuboCop is a Ruby code style checking and code formatting tool
  gem 'rubocop', '~> 1.54', require: false
  # Code style checking for RSpec files
  gem 'rubocop-rspec', '~> 2.22', require: false

  # Strategies for cleaning databases using ActiveRecord
  gem 'database_cleaner-active_record', '~> 2.1'
  # factory_bot_rails provides integration between factory_bot and rails 5.0 or newer
  gem 'factory_bot_rails', '~> 6.2'
  # Ffaker generates dummy data
  gem 'ffaker', '~> 2.21'
  # A set of RSpec matchers for testing Pundit authorisation policies.
  gem 'pundit-matchers', '~> 3.1'

  # Preview mail in the browser instead of sending.
  gem 'letter_opener', '~> 1.8'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 4.1'
  gem 'spring-watcher-listen', '~> 2.1'

  # Brakeman detects security vulnerabilities in Ruby on Rails applications via static analysis
  gem 'brakeman', '~> 6.0'

  # Flay analyzes code for structural similarities.
  gem 'flay', '~> 2.13', require: false

  # Code smell detector for Ruby
  gem 'reek', '~> 6.1', require: false

  # This Rake task investigates the application's routes definition
  gem 'traceroute', '~> 0.8'

  # Generate a diagram based on application's Active Record models.
  gem 'rails-erd', '~> 1.7.2'

  # Annotate Rails classes with schema and routes info
  gem 'annotate', '~> 3.2'

  # Quick automated code review of your changes
  gem 'pronto', '~> 0.11', require: false
  gem 'pronto-brakeman', '~> 0.11', require: false
  gem 'pronto-flay', '~> 0.11', require: false
  gem 'pronto-reek', '~> 0.11', require: false
  gem 'pronto-rubocop', '~> 0.11', require: false
end

group :test do
  # The instafailing RSpec progress bar formatter
  gem 'fuubar', '~> 2.5'
  # rspec-rails is a testing framework for Rails 5+
  gem 'rspec-rails', '~> 6.0'
  # RSpec test doubles for ActiveModel and ActiveRecord
  gem 'rspec-activemodel-mocks', '~> 1.1'
  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality
  gem 'shoulda-matchers', '~> 5.3'
  # Guard::RSpec automatically run your specs (much like autotest)
  gem 'guard-rspec', '~> 4.7', require: false
  # Code coverage for Ruby with a powerful configuration library and automatic merging of coverage across test suites
  gem 'simplecov', '~> 0.20', require: false
  # Rcov style formatter for SimpleCov
  gem 'simplecov-rcov', '~> 0.3', require: false
  # A SimpleCov formatter for test driven development
  gem 'simplecov-tdd', github: 'longtrieu/simplecov-tdd', require: false
  # Brings back `assigns` and `assert_template` to your Rails tests
  gem 'rails-controller-testing', '~> 1.0'
  # Record your test suite's HTTP interactions and replay them during future test runs
  gem 'vcr', '~> 6.2'
  # Allows stubbing HTTP requests and setting expectations on HTTP requests
  gem 'webmock', '~> 3.18'
  # A gem providing "time travel", "time freezing", and "time acceleration" capabilities, making it simple to
  # test time-dependent code.
  gem 'timecop', '~> 0.9'
end
