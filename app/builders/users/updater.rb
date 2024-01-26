# frozen_string_literal: true

module Users
  class Updater < ApplicationBuilder
    def initialize(params, resource)
      @params = params
      @resource = resource
    end

    def call
      user_updater
    end

    private

    attr_reader :params, :resource

    def user_updater
      return error(resource) unless resource.update_columns(**params)

      success(resource)
    end
  end
end
