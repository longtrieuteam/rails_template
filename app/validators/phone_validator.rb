# frozen_string_literal: true

class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, (options[:message] || :invalid)) if value.blank? || !self.class.valid?(value)
  end

  class << self
    def valid?(phone)
      Utils::PhoneNumber.new(phone:).vietnamese_phone?
    end
  end
end
