# frozen_string_literal: true

require 'rails_helper'

describe Users::Finder do
  let(:user) { create(:user) }
  let(:phone_params) do
    { phone: user.phone }
  end
  let(:username_params) do
    { username: user.username }
  end
  let(:phone_password_params) do
    { phone: user.phone, password: user.password }
  end
  let(:username_password_params) do
    { username: user.username, password: user.password }
  end

  describe '.find_by_phone' do
    it 'calls #find_by_phone' do
      expect_any_instance_of(described_class).to receive(:find_by_phone)

      described_class.find_by_phone(phone_params)
    end
  end

  describe '.find_by_phone_and_password' do
    it 'calls #find_by_phone_and_password' do
      expect_any_instance_of(described_class).to receive(:find_by_phone_and_password)

      described_class.find_by_phone_and_password(phone_password_params)
    end
  end

  describe '.username_password_params' do
    it 'calls #username_password_params' do
      expect_any_instance_of(described_class).to receive(:find_by_username_and_password)

      described_class.find_by_username_and_password(username_params)
    end
  end

  describe '#find_by_phone' do
    context 'with valid phone' do
      let(:user_finder) { described_class.new(phone_params) }

      before do
        allow_any_instance_of(described_class).to receive(:validate_phone!).and_return(true)
      end

      it 'returns user' do
        expect(user_finder.find_by_phone).to eq(user)
      end
    end

    context 'with invalid phone' do
      let(:user_finder) { described_class.new({ phone: 123 }) }

      it 'raises exception' do
        expect { user_finder.find_by_phone }.to raise_exception(Error::GatewayError)
      end
    end
  end

  describe '#find_by_username' do
    let(:user_finder) { described_class.new(username_params) }

    it 'returns user' do
      expect(user_finder.find_by_username).to eq(user)
    end
  end

  describe '#find_by_phone_and_password' do
    let(:user_finder) { described_class.new(phone_password_params) }

    before do
      allow(described_class).to receive(:find_by_phone).and_return(user)
    end

    it 'returns user' do
      expect(user_finder.find_by_phone_and_password).to eq(user)
    end
  end

  describe '#find_by_username_and_password' do
    let(:user_finder) { described_class.new(username_password_params) }

    before do
      allow_any_instance_of(described_class).to receive(:find_by_username).and_return(user)
    end

    it 'returns user' do
      expect(user_finder.find_by_username_and_password).to eq(user)
    end
  end
end
