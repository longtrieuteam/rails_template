# frozen_string_literal: true

module Error
  module ExceptionErrorBuilder
    def error_builder(field, error_type, messages, option = {})
      {
        details: {
          "#{field}": [
            {
              error: error_type,
              value: option[:value],
            }.merge(option[:details] || {}),
          ],
        },
        error: [messages].flatten.map { |message| "#{field.to_s.titleize} #{message}" }.join(', '),
        errors: {
          "#{field}": [messages].flatten,
        },
      }.to_json
    end

    def activerecord_errors_builder(errors)
      return errors if !errors.is_a?(ActiveModel::Errors) || errors.blank?

      {
        details: errors.details,
        error: errors.messages.values.flatten.join(' '),
        errors: errors.messages,
      }.to_json
    end

    def error_message(error)
      {
        success?: false,
        errors: error_builder(error, :invalid, 'invalid'),
      }.to_mash
    end
  end
end
