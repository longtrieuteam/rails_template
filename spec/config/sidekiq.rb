# frozen_string_literal: true

require 'sidekiq/testing'

RSpec.configure do |config|
  config.include ActiveJob::TestHelper

  config.before(:each) do
    clear_enqueued_jobs
  end
end
