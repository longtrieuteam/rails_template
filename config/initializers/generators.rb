# frozen_string_literal: true

# Configuring Generators. For more details, see:
#   - https://guides.rubyonrails.org/generators.html#customizing-your-workflow
#   - https://stackoverflow.com/questions/41432117/railsgenerator-is-not-creating-factory-in-spec-folder
Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
  g.test_framework :rspec
  g.fixture_replacement :factory_bot, dir: 'spec/factories'
end
