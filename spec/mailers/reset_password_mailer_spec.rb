# frozen_string_literal: true

require 'rails_helper'

describe ResetPasswordMailer do
  describe '.reset_password' do
    let(:user) { create(:user) }
    let(:otp) { '123456' }
    let(:mail) { described_class.reset_password(user, otp) }

    it 'renders the correct email info' do
      expect(mail.from).to eq(['from@example.com'])
      expect(mail.to).to eq([user.email])
      expect(mail.reply_to).to eq(nil)
      expect(mail.subject).to eq('Reset Password Instruction')
    end

    it 'renders the correct email content' do
      actual = mail.body.decoded
      expect(actual).to match(user.email)
      expect(actual).to match(otp)
    end
  end
end
