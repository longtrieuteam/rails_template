# frozen_string_literal: true

module Users
  class ResetPassword < ApplicationBuilder
    def initialize(params)
      @params = params
    end

    def call
      reset_password
    end

    private

    attr_reader :params, :resource

    def reset_password # rubocop:disable Metrics/AbcSize
      return error_message(:password_or_password_confirmation) if params[:password] != params[:password_confirmation]

      user = User.where(email: params[:email], otp: params[:otp].to_s).first
      return error_message(:email_or_otp) unless user

      if user.update(password: params[:password], otp: nil)
        success(user)
      else
        error(user)
      end
    end
  end
end
