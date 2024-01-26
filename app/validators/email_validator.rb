# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, (options[:message] || :invalid)) unless self.class.valid?(value)
  end

  class << self
    # rubocop:disable Layout/LineLength
    def valid?(value)
      return true if value.blank?

      email_pattern = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      email_pattern.match?(value)
    end
    # rubocop:enable Layout/LineLength
  end
end
