# frozen_string_literal: true

module Users
  class PasswordUpdater < ApplicationBuilder
    def initialize(params, resource)
      @params = params
      @resource = resource
    end

    def call
      password_updater
    end

    private

    attr_reader :params, :resource

    def password_updater
      return error(resource) unless resource.update_with_password(params)

      success(resource)
    end
  end
end
