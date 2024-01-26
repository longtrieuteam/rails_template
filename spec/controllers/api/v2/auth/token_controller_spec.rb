# frozen_string_literal: true

require 'rails_helper'

describe Api::V2::Auth::TokenController do
  let(:user) { build_stubbed(:user) }

  describe '#create' do
    context 'with correct phone and password' do
      before do
        allow(Users::Finder).to receive(:find_by_username_and_password).and_return(user)
      end

      it 'returns 201 status code' do
        post :create

        expect(response.status).to eq(201)
      end
    end

    context 'with incorrect phone and password' do
      before do
        allow(Users::Finder).to receive(:find_by_username_and_password).and_return(nil)
      end

      it 'returns 401 status code' do
        post :create

        expect(response.status).to eq(401)
      end
    end
  end

  describe '#refresh' do
    context 'when user not signed-in' do
      it 'returns 401 status code' do
        post :refresh

        expect(response.status).to eq(401)
      end
    end

    context 'when user signed in' do
      before do
        allow_any_instance_of(described_class).to receive(:authenticate_user!).and_return(true)
        allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
      end

      it 'returns 200 status code' do
        post :refresh

        expect(response.status).to eq(200)
      end
    end
  end

  describe '#profile' do
    context 'when user not signed-in' do
      it 'returns 401 status code' do
        post :refresh

        expect(response.status).to eq(401)
      end
    end

    context 'when user signed in' do
      before do
        allow_any_instance_of(described_class).to receive(:authenticate_user!).and_return(true)
        allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
      end

      it 'returns 200 status code' do
        get :profile

        expect(response.status).to eq(200)
      end

      it 'returns user data' do
        get :profile

        serialize_user = Api::V2::UserSerializer.new(user).serializable_hash

        body = JSON.parse(response.body).deep_symbolize_keys
        body[:data][:type] = body[:data][:type].to_sym

        expect(body).to eq(serialize_user)
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

  describe '#user' do
    let(:params) { { username: user.username, password: 'password' } }

    before do
      allow_any_instance_of(described_class).to receive(:token_params).with(no_args).and_return(params)
    end

    it 'returns a user' do
      expect(Users::Finder).to receive(:find_by_username_and_password).with(params).and_return(user)

      subject.send(:user)
    end
  end

  describe '#token_params' do
    let(:token_params) do
      %i[username password]
    end

    it 'returns permitted params' do
      expect(controller.params).to receive(:permit).with(*token_params)

      subject.send(:token_params)
    end
  end
end
