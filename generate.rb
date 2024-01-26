# frozen_string_literal: true

require 'active_support/all'

APP_NAME = ARGV.first
return unless APP_NAME

APP_NAMES = [
  { old: 'RailsTemplate', new: APP_NAME.camelize },
  { old: 'Rails Template', new: APP_NAME.titlecase },
  { old: 'Rails_Template', new: APP_NAME.titlecase.gsub(' ', '_') },
  { old: 'rails_template', new: APP_NAME.underscore },
  { old: 'rails-template', new: APP_NAME.underscore.dasherize },
  { old: 'RAILS_TEMPLATE', new: APP_NAME.underscore.upcase },
].freeze

EXCLUDE_PATHS = [
  'tmp',
  'bin',
  'coverage',
  'log',
  'node_modules',
  'public',
  'vendor',
  '.git',
  'generate.rb',
  'config/master.key',
  'config/credentials.yml.enc',
].freeze

def replace_text(text)
  APP_NAMES.reduce(text) do |result, name|
    result.gsub(name[:old], name[:new])
  end
end

def replace_content_in_files
  Dir.glob('**/*', File::FNM_DOTMATCH).each do |file|
    next if File.directory?(file)
    next if EXCLUDE_PATHS.any? { |path| file.include?(path) }

    new_text = replace_text(File.read(file))
    File.open(file, 'w') { |f| f.puts new_text }
  end
end

replace_content_in_files

puts 'Generate Successfully'
