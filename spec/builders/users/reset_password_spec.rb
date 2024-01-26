# frozen_string_literal: true

require 'rails_helper'

describe Users::ResetPassword do
  include ServiceResponder

  subject { described_class.new(params) }
  let(:params) do
    {
      otp: 'otp',
      email: 'example@gmail.com',
      password: '{{user_password}}',
      password_confirmation: '{{user_password}}',
    }
  end
  let(:user) { create(:user) }

  describe '#call' do
    it 'calls methods' do
      expect_any_instance_of(described_class).to receive(:reset_password)

      subject.call
    end
  end

  describe '#reset_password' do
    context 'when password and password_confirm are different' do
      let(:invalid_params) do
        {
          otp: 'otp',
          email: 'example@gmail.com',
          password: 'user_password',
          password_confirmation: 'password_confirmation',
        }
      end

      it 'returns errors' do
        expected = {
          success?: false,
          errors: { details: { password_or_password_confirmation: [{ error: 'invalid', value: nil }] },
                    error: 'Password Or Password Confirmation invalid',
                    errors: { password_or_password_confirmation: ['invalid'] }, }.to_json,
        }
        actual = described_class.new(invalid_params).send(:reset_password)

        expect(actual.to_json).to eq(expected.to_json)
      end
    end

    context 'when update with invalid otp or email' do
      before do
        allow(User).to receive_message_chain(:where, :first).with(email: params[:email],
                                                                  otp: params[:otp]).with(no_args).and_return(nil)
        allow(subject).to receive(:error_message).with(:email_or_otp).and_return('errors')
      end

      it 'returns errors' do
        expect(subject.send(:reset_password)).to eq('errors')
      end
    end

    context 'when update successfully' do
      before do
        allow(User).to receive_message_chain(:where, :first).with(email: params[:email],
                                                                  otp: params[:otp]).with(no_args).and_return(user)
        allow(user).to receive(:update).with(password: params[:password], otp: nil).and_return(true)
      end

      it 'returns messages' do
        expect(subject.send(:reset_password)).to eq(success(user))
      end
    end

    context 'when update unsuccessfully' do
      before do
        allow(User).to receive_message_chain(:where, :first).with(email: params[:email],
                                                                  otp: params[:otp]).with(no_args).and_return(user)
        allow(user).to receive(:update).with(password: params[:password], otp: nil).and_return(false)
      end

      it 'returns messages' do
        expect(subject.send(:reset_password)).to eq(error(user))
      end
    end
  end
end
