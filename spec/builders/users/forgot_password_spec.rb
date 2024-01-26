# frozen_string_literal: true

require 'rails_helper'

describe Users::ForgotPassword do
  include ServiceResponder

  subject { described_class.new(params) }
  let(:params) do
    {
      email: user.email,
    }
  end
  let(:user) { create(:user) }

  describe '#call' do
    it 'calls methods' do
      expect_any_instance_of(described_class).to receive(:forgot_password)

      subject.call
    end
  end

  describe '#forgot_password' do
    context 'when user not exist' do
      before do
        allow(User).to receive(:find_by_email).with(user.email).and_return(nil)
        allow(subject).to receive(:error_message).with(:email).and_return('errors')
      end

      it 'returns errors' do
        expected = 'errors'
        actual = subject.send(:forgot_password)

        expect(actual).to eq(expected)
      end
    end

    context 'when user exist' do
      let(:otp) { 123_456 }

      before do
        allow(User).to receive(:find_by_email).with(user.email).and_return(user)
        allow(subject).to receive(:rand).with(100_000..999_999).and_return(otp)
      end

      it 'calls methods' do
        expect(user).to receive(:update_columns).with(otp:)
        expect(ResetPasswordMailer).to receive_message_chain(:reset_password, :deliver_now).with(user,
                                                                                                 otp).with(no_args)

        subject.send(:forgot_password)
      end
    end
  end
end
