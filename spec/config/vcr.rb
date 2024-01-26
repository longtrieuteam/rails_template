# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  # Configures RSpec to use a VCR cassette for any example tagged with `:vcr`.
  config.configure_rspec_metadata!

  config.before_record do |interaction|
    interaction.response.body.force_encoding('UTF-8')
  end
end
