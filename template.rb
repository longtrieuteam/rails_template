# frozen_string_literal: true

TEMPLATE_APP = "#{Time.now.strftime('%Y%m%d%H%M%S')}_template_app".freeze

def source_paths
  [File.expand_path(TEMPLATE_APP)]
end

def add_gems
  global_content = <<-RUBY
    # "Autoload dotenv in Rails"
    gem 'dotenv-rails'

    # "Generate Active Record models from an existing schema"
    gem 'magic_models', git: 'https://github.com/longtrieuteam/magic_models'

    # "Use postgresql as the database for Active Record"
    gem 'pg'

    # "Makes http request"
    gem 'httparty'
  RUBY

  dev_test_content = <<-RUBY
    # Adds 'step', 'next', 'finish', 'continue' and 'break' commands to control execution
    gem 'pry-byebug'

    # Use Pry as your rails console
    gem 'pry-rails'

    # Pretty print Ruby objects to visualize their structure
    gem 'awesome_print', require: 'ap'

    # RuboCop is a Ruby code style checking and code formatting tool
    gem 'rubocop', require: false

    # Code style checking for RSpec files
    gem 'rubocop-rspec', require: false

    # Strategies for cleaning databases using ActiveRecord
    gem 'database_cleaner-active_record'

    # factory_bot_rails provides integration between factory_bot and rails 5.0 or newer
    gem 'factory_bot_rails'

    # Ffaker generates dummy data
    gem 'ffaker'

    # Preview mail in the browser instead of sending.
    gem 'letter_opener'
  RUBY

  test_content = <<-RUBY
    # The instafailing RSpec progress bar formatter
    gem 'fuubar'

    # rspec-rails is a testing framework for Rails 5+
    gem 'rspec-rails'

    # RSpec test doubles for ActiveModel and ActiveRecord
    gem 'rspec-activemodel-mocks'

    # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality
    gem 'shoulda-matchers'

    # Guard::RSpec automatically run your specs (much like autotest)
    gem 'guard-rspec', require: false

    # Code coverage for Ruby with a powerful configuration library and automatic merging of coverage across test suites
    gem 'simplecov', require: false

    # Rcov style formatter for SimpleCov
    gem 'simplecov-rcov', require: false

    # A SimpleCov formatter for test driven development
    gem 'simplecov-tdd', github: 'longtrieu/simplecov-tdd', require: false

    # Brings back `assigns` and `assert_template` to your Rails tests
    gem 'rails-controller-testing'

    # Record your test suite's HTTP interactions and replay them during future test runs
    gem 'vcr'

    # Allows stubbing HTTP requests and setting expectations on HTTP requests
    gem 'webmock'

    # A gem providing "time travel", "time freezing", and "time acceleration" capabilities, making it simple to test time-dependent code.
    gem 'timecop'

    # Set of matchers and helpers for RSpec 3 to allow you test your JSON API responses like a pro
    gem 'rspec-json_expectations'
  RUBY

  dev_content = <<-RUBY
    # Quick automated code review of your changes
    gem 'pronto', '0.11.2', require: false
    gem 'pronto-standardrb', '0.1.2', require: false
    gem 'pronto-brakeman', '0.11.2', require: false
    gem 'pronto-flay', '0.11.1', require: false
    gem 'pronto-reek', '0.11.1', require: false
    gem 'pronto-rubocop', '0.11.5', require: false
  RUBY

  insert_into_file 'Gemfile', "#{global_content}\n\n", before: "group :development, :test do\n"
  insert_into_file 'Gemfile', "#{dev_test_content}\n", after: "group :development, :test do\n"
  insert_into_file 'Gemfile', "#{test_content}\n", after: "group :test do\n"
  insert_into_file 'Gemfile', "#{dev_content}\n", after: "group :development do\n"
end

def copy_templates
  directory 'script'
  directory 'config', force: true
  directory 'lib', force: true
  directory 'spec', force: true

  copy_file '.env.template'
  copy_file '.rubocop.yml', force: true
  copy_file '.rspec', force: true
  copy_file '.gitignore', force: true

  copy_file 'archive/README.md', 'README.md', force: true
  gsub_file 'README.md', 'APPNAME', app_name.titlecase
  gsub_file 'README.md', 'app_name', app_name.underscore
end

def check_rubocop
  run 'rubocop --parallel -A'
end

def clone_app_template
  run "git clone git@github.com:longtrieuteam/rails_template.git #{TEMPLATE_APP}"
end

def remove_app_template
  run 'pwd'
  run "rm -rf #{TEMPLATE_APP}"
end

def first_commit
  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end

def say_notice
  say
  say "#{app_name} app successfully created! 👍", :green
  say
  say 'Switch to your app by running:'
  say "$ cd #{app_name}", :yellow
end

def db_choosen
  user_input = ''
  while user_input != 1 && user_input != 2
    say "Which DB do you want to use? Choose 1 or 2:", :green
    say "1: Postgres", :green
    say "2: SQLite:", :green

    user_input = STDIN.gets.chomp.to_i
    if user_input == 1
      copy_file 'archive/pg_database.yml', 'config/database.yml', force: true
      copy_file '.env.template', '.env', force: true
    elsif user_input == 2
      copy_file 'archive/sql_lite_database.yml', 'config/database.yml', force: true
      run 'rails db:migrate'
    else
      say 'You have to choose 1 or 2', :red
    end
  end
end

def guard_init
  run 'guard init'
end

# Main
clone_app_template
source_paths
add_gems

after_bundle do
  copy_templates
  db_choosen
  guard_init

  remove_app_template
  check_rubocop
  first_commit
  say_notice
end
