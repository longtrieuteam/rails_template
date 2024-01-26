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
  add_group 'Admin', 'app/admin'
  add_group 'Builders', 'app/builders'
  add_group 'Channels', 'app/channels'
  add_group 'Controllers', 'app/controllers'
  add_group 'Finders', 'app/finders'
  add_group 'Helpers', 'app/helpers'
  add_group 'Jobs', 'app/jobs'
  add_group 'Libraries', 'lib'
  add_group 'Mailers', 'app/mailers'
  add_group 'Middlewares', 'app/middlewares'
  add_group 'Models', 'app/models'
  add_group 'Policies', 'app/policies'
  add_group 'Serializers', 'app/serializers'
  add_group 'Services', 'app/services'
  add_group 'Validators', 'app/validators'
  add_group 'Workers', 'app/workers'

  add_group 'Long files' do |src_file|
    src_file.lines.count > 100
  end

  add_filter 'app/models/application_record.rb'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/mailers/application_mailer.rb'

  # Ignore files for development environment
  add_filter 'app/services/locations/visible_options_dev_decorator.rb'

  add_filter 'app/channels/'
  add_filter '/config/'
  add_filter '/spec/'

  minimum_coverage 80
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
