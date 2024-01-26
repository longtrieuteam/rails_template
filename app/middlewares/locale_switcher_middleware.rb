# frozen_string_literal: true

class LocaleSwitcherMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    locale_to_restore = I18n.locale

    I18n.locale = user_preferred_locale(env['HTTP_X_LOCALE']) || I18n.default_locale

    @app.call(env)
  ensure
    I18n.locale = locale_to_restore
  end

  private

  def user_preferred_locale(http_locate)
    return I18n.locale if http_locate.blank?
    return I18n.locale if I18n.available_locales.exclude?(http_locate.to_sym)

    http_locate.to_sym
  end
end
