# frozen_string_literal: true

module Utils
  module I18n
    def i18n_error_model_attr(resource, path)
      ::I18n.t("activerecord.errors.models.#{resource}.attributes.#{path}")
    end
  end
end
