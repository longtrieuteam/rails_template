# frozen_string_literal: true

class ApplicationFinder
  include Error::ExceptionErrorBuilder
  include Utils::I18n

  # Ruby 2.7 adds shorthand syntax for arguments forwarding
  def self.call(*args, **kwargs, &) # rubocop:disable Style/ArgumentsForwarding
    new(*args, **kwargs, &).call # rubocop:disable Style/ArgumentsForwarding
  end

  def unix_time_parser(unix_time, field_name)
    return Time.at(unix_time.to_i) if unix_time.to_i.positive?

    raise Error::GatewayError, error_builder(field_name, :invalid, message(field_name))
  end

  def message(field_name)
    class_name = self.class.name.deconstantize.underscore
    I18n.t("finders.#{class_name}.errors.#{field_name}.invalid")
  end
end
