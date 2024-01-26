# frozen_string_literal: true

require 'simplecov'
require 'simplecov-rcov'
require 'simplecov/tdd'
require 'simplecov_json_formatter'

SimpleCov.command_name 'RSpec'
SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::RcovFormatter,
  SimpleCov::Formatter::Tdd,
  SimpleCov::Formatter::JSONFormatter,
]

SimpleCov.start :rails do
  add_group 'Long files' do |src_file|
    src_file.lines.count > 100
  end

  # Ignore files for development environment
  add_filter 'app/models/application_record.rb'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/mailers/application_mailer.rb'

  add_filter 'app/channels/'
  add_filter '/config/'
  add_filter '/spec/'

  minimum_coverage 60
end

SimpleCov::Formatter::Tdd.output_style = :verbose

module SimpleCov
  module Formatter
    class RcovFormatter
      private

      def write_file(template, output_filename, binding)
        rcov_result = template.result(binding)

        File.write(output_filename, rcov_result.force_encoding('UTF-8'))
      end
    end
  end
end
