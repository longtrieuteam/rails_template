# frozen_string_literal: true

module Users
  class Finder < ApplicationFinder
    attr_reader :params

    CLASS_METHODS_EXPORTED = %i[
      find_by_phone
      find_by_phone_and_password
      find_by_username_and_password
    ].freeze

    class << self
      CLASS_METHODS_EXPORTED.each do |method_name|
        define_method method_name do |params|
          new(params).send(method_name)
        end
      end
    end

    def initialize(params = {})
      @params = params
    end

    def find_by_phone
      validate_phone!

      @find_by_phone ||= User.find_by(phone: phone.to_s)
    end

    def find_by_username
      @find_by_username ||= User.find_by(username: params[:username])
    end

    def find_by_phone_and_password
      return if params[:phone].blank? || params[:password].blank?
      return unless find_by_phone&.valid_password?(params[:password])

      find_by_phone
    end

    def find_by_username_and_password
      return if params[:username].blank? || params[:password].blank?
      return unless find_by_username&.valid_password?(params[:password])

      find_by_username
    end

    private

    def validate_phone!
      return if phone.vietnamese_phone?

      raise Error::GatewayError, error_builder(:phone, :invalid, i18n_error_model_attr(:user, 'phone.invalid'))
    end

    def phone
      @phone ||= Utils::PhoneNumber.new(phone: params[:phone])
    end
  end
end
