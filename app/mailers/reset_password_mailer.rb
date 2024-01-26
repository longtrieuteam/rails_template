# frozen_string_literal: true

class ResetPasswordMailer < ApplicationMailer
  def reset_password(user, otp)
    @user = user
    @otp = otp

    mail(to: @user.email, subject: 'Reset Password Instruction')
  end
end
