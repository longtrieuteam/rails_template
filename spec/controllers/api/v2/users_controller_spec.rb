# frozen_string_literal: true

require 'rails_helper'

describe Api::V2::UsersController do
  include ServiceResponder
  include Error::ExceptionErrorBuilder

  let(:user) { create(:user) }

  describe '#create' do
    context 'when create with invalid params' do
      let(:expected) do
        {
          details: { password_or_password_confirmation: [{ error: 'invalid', value: nil }] },
          error: 'Password Or Password Confirmation invalid',
          errors: { password_or_password_confirmation: ['invalid'] },
        }.to_json
      end

      let(:params) do
        { user: { username: 'invalid', email: 'invalid', password: 'invalid' } }
      end

      it 'returns error' do
        post(:create, params:)

        expect(response.code).to eq('422')
        expect(response.body).to eq(expected)
      end
    end

    context 'when create with valid params' do
      let(:user_params) do
        attributes_for(:user).merge({ password_confirmation: user.password }).to_mash
      end

      it 'returns user' do
        post :create, params: { user: user_params }

        attributes = JSON.parse(response.body).to_mash.data.attributes
        expect(response.code).to eq('201')
        expect(attributes.username).to eq(user_params.username)
        expect(attributes.email).to eq(user_params.email)
      end
    end
  end

  describe '#update_info' do
    before do
      allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
    end

    context 'when update info with invalid params' do
      let(:expected) do
        {
          details: { params: [{ error: 'invalid', value: nil }] },
          error: 'Params Invalid',
          errors: { params: ['Invalid'] },
        }.to_json
      end

      let(:params) do
        { user: {} }
      end

      it 'returns error' do
        put(:update_info, params:)

        expect(response.code).to eq('400')
        expect(response.body).to eq(expected)
      end
    end

    context 'when update info with valid params' do
      let(:params) do
        { user: { fullname: 'Fullname of user' } }
      end

      it 'returns response' do
        put(:update_info, params:)

        expect(response.code).to eq('200')
      end
    end
  end

  describe '#update_password' do
    before do
      allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
    end

    context 'when update password with invalid params' do
      let(:expected) do
        {
          details: {
            password: [{ error: 'too_short', count: 8 }],
          },
          error: 'Password must be at least 8 characters.',
          errors: { password: ['Password must be at least 8 characters.'] },
        }.to_json
      end

      let(:params) do
        { user: { current_password: user.password, password: 'invalid', password_confirmation: 'invalid' } }
      end

      it 'returns error' do
        put(:update_password, params:)

        expect(response.code).to eq('422')
        expect(response.body).to eq(expected)
      end
    end

    context 'when update password with valid params' do
      let(:params) do
        { user: { current_password: user.password, password: 'user_password', password_confirmation: 'user_password' } }
      end

      it 'returns response' do
        put(:update_password, params:)

        expect(response.code).to eq('200')
      end
    end
  end

  describe '#update_role' do
    before do
      allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
    end

    context 'when update role with invalid params' do
      let(:expected) do
        {
          details: { role: [{ error: 'invalid', value: nil }] },
          error: 'Role invalid',
          errors: { role: ['invalid'] },
        }.to_json
      end

      let(:params) do
        { user: { role: 'invalid' } }
      end

      it 'returns error' do
        put(:update_role, params:)

        expect(response.code).to eq('422')
        expect(response.body).to eq(expected)
      end
    end

    context 'when update role with valid params' do
      let(:params) do
        { user: { role: 'premium' } }
      end

      it 'returns response' do
        put(:update_role, params:)

        expect(response.code).to eq('200')
      end
    end
  end

  describe '#forgot_password' do
    context 'when user send invalid email' do
      let(:params) do
        { user: { email: 'invalid_email' } }
      end
      let(:service_response) do
        {
          success?: false,
          errors: error_builder(:email, :invalid, 'invalid'),
        }.to_mash
      end

      before do
        allow_any_instance_of(described_class).to receive(:permit_params).with(:forgot_password).and_return(params)
        allow(Users::ForgotPassword).to receive(:call).with(params).and_return(service_response)
      end

      it 'returns error' do
        post(:forgot_password, params:)

        expect(response.code).to eq('422')
        expect(response.body).to eq(service_response.errors)
      end
    end

    context 'when user send valid email' do
      let(:params) do
        { user: { email: user.email } }
      end
      let(:service_response) do
        { success?: true, reset_password_token: 'token' }.to_mash
      end

      before do
        allow_any_instance_of(described_class).to receive(:permit_params).with(:forgot_password).and_return(params)
        allow(Users::ForgotPassword).to receive(:call).with(params).and_return(service_response)
      end

      it 'returns messsage' do
        post(:forgot_password, params:)

        expect(response.code).to eq('200')
        expect(response.body).to eq({ result: 'success' }.to_json)
      end
    end
  end

  describe '#reset_password' do
    context 'when reset password with invalid params' do
      let(:expected) do
        {
          details: { password_or_password_confirmation: [{ error: 'invalid', value: nil }] },
          error: 'Password Or Password Confirmation invalid',
          errors: { password_or_password_confirmation: ['invalid'] },
        }.to_json
      end

      let(:params) do
        {
          user: {
            reset_password_token: user.reset_password_token,
            password: 'invalid',
            password_confirmation: 'invalid2',
          },
        }
      end

      it 'returns error' do
        post(:reset_password, params:)

        expect(response.code).to eq('422')
        expect(response.body).to eq(expected)
      end
    end

    context 'when reset password with valid params' do
      let(:params) do
        {
          user: {
            reset_password_token: 'reset_password_token',
            password: 'invalid',
            password_confirmation: 'invalid2',
          },
        }
      end

      before do
        allow_any_instance_of(described_class).to receive(:permit_params).with(:reset_password).and_return(params)
        allow(Users::ResetPassword).to receive(:call).with(params).and_return(success(user))
      end

      it 'returns response' do
        post(:reset_password, params:)

        expect(response.code).to eq('200')
      end
    end
  end

  describe '#resource_serializer' do
    it 'returns correct serializer' do
      actual = subject.send(:resource_serializer)
      expected = Api::V2::UserSerializer

      expect(actual).to eq(expected)
    end
  end

  describe '#resource' do
    before do
      allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
    end

    it 'returns user' do
      actual = subject.send(:resource)
      expected = user

      expect(actual).to eq(expected)
    end
  end

  describe '#permitted_attributes' do
    it 'returns permitted attributes' do
      expected =        {
        create: %i[username email password password_confirmation],
        update_info: %i[fullname],
        update_password: %i[current_password password password_confirmation],
        update_role: %i[role],
        forgot_password: %i[email],
        reset_password: %i[email otp password password_confirmation],
      }
      actual = subject.send(:permitted_attributes)

      expect(actual).to eq(expected)
    end
  end

  describe 'permit_params' do
    let(:permitted_attributes) do
      {
        action: %i[value1 value2],
      }
    end

    before do
      allow(subject).to receive(:permitted_attributes).and_return(permitted_attributes)
    end

    it 'returns permitted params' do
      expect(controller.params).to receive_message_chain(:require, :permit)
        .with(:user).with(*permitted_attributes[:action])

      subject.send(:permit_params, 'action')
    end
  end
end
