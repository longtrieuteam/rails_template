# frozen_string_literal: true

require 'rails_helper'

describe Http::Exceptions do
  describe '.wrap_exception' do
    exceptions = [
      SocketError,
      Errno::ETIMEDOUT,
      Net::ReadTimeout,
      Net::OpenTimeout,
      Net::ProtocolError,
      Errno::ECONNREFUSED,
      Errno::EHOSTDOWN,
      Errno::ECONNRESET,
      Errno::ENETUNREACH,
      Errno::EHOSTUNREACH,
      Errno::ECONNABORTED,
      OpenSSL::SSL::SSLError,
      EOFError,
    ]

    exceptions.each do |exception|
      context "when yield raise exception #{exception}" do
        it 'raises Http::Exceptions::HttpException' do
          expect do
            described_class.wrap_exception { raise exception }
          end.to raise_error(Http::Exceptions::HttpException)
        end
      end
    end

    context 'when yielded' do
      it 'yields with no args' do
        expect do |b|
          described_class.wrap_exception(&b)
        end.to yield_with_no_args
      end
    end
  end

  describe '.check_response' do
    context 'when response code is between 200 and 300' do
      let(:response) { { code: 200 }.to_mash }

      it 'returns response' do
        expect(described_class.check_response!(response)).to eq(response)
      end
    end

    context 'when response code is not between 200 and 300' do
      let(:response) { { code: 500 }.to_mash }

      it 'raises exception' do
        expect do
          described_class.check_response!(response)
        end.to raise_error(Http::Exceptions::HttpException)
      end
    end
  end

  describe '.wrap_and_check' do
    it 'calls wrap_exception' do
      expect(described_class).to receive(:wrap_exception)

      described_class.wrap_and_check
    end
  end

  describe '.configure' do
    it 'calls configure' do
      expect do |b|
        described_class.configure(&b)
      end.to yield_control
    end
  end

  describe '.configuration' do
    it 'calls configuration' do
      expect(described_class.configuration.class).to eq(Http::Exceptions::Configuration)
    end
  end
end
