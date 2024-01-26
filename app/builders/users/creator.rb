# frozen_string_literal: true

module Users
  class Creator < ApplicationBuilder
    def initialize(params)
      @params = params_builder(params)
    end

    def call
      user_creator
    end

    private

    attr_reader :params

    def user_creator
      return error_message(:password_or_password_confirmation) if params[:password] != params[:password_confirmation]

      user = User.new(params)
      return error(user) unless user.save

      success(user)
    end

    def params_builder(params)
      params.merge(fullname: params[:username])
    end
  end
end
