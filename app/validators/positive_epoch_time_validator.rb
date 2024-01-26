# frozen_string_literal: true

class PositiveEpochTimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, (options[:message] || :invalid_unix_time)) unless self.class.valid?(value)
  end

  class << self
    def valid?(value)
      return true if value.nil?

      value > Time.at(0)
    end
  end
end
