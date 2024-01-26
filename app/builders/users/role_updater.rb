# frozen_string_literal: true

module Users
  class RoleUpdater < ApplicationBuilder
    def initialize(params, resource)
      @params = params
      @resource = resource
    end

    def call
      role_updater
    end

    private

    attr_reader :params, :resource

    def role_updater
      resource.add_role(params[:role])

      success(resource)
    rescue Exception
      error_message(:role)
    end
  end
end
