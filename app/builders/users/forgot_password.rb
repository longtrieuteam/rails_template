# frozen_string_literal: true

module Users
  class ForgotPassword < ApplicationBuilder
    def initialize(params)
      @params = params
    end

    def call
      forgot_password
    end

    private

    attr_reader :params

    def forgot_password
      user = User.find_by_email(params[:email])

      if user
        otp = rand(100_000..999_999)
        user.update_columns(otp:)
        ResetPasswordMailer.reset_password(user, otp).deliver_now

        { success?: true }.to_mash
      else
        error_message(:email)
      end
    end
  end
end
