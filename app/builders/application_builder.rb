# frozen_string_literal: true

class ApplicationBuilder
  include ServiceResponder
  include Error::ExceptionErrorBuilder
  include Utils::I18n

  def self.call(*args, **kwargs, &) # rubocop:disable Style/ArgumentsForwarding
    new(*args, **kwargs, &).call # rubocop:disable Style/ArgumentsForwarding
  end
end
