# frozen_string_literal: true

require 'rails_helper'

describe Http::Requester do
  let(:url) { 'http://api.shoutcloud.io/V1/SHOUT' }
  let(:body) { { input: 'rspec' } }

  describe '.make_request', vcr: { cassette_name: 'post public api' } do
    context 'when send with valid params' do
      let(:actual) { described_class.make_request('post', url, body) }

      it 'returns 200 status code' do
        expect(actual.code).to eq(200)
      end
    end

    context 'when error with body' do
      let(:actual) { described_class.make_request('get', 'invalid_url') }
      let(:body_result) do
        {
          body: { message: 'An error has occurred while processing response.' },
          code: 400,
        }
      end
      let(:http_exception) do
        options = { response: body_result }.to_mash
        Http::Exceptions::HttpException.new(options)
      end

      before do
        allow(Http::Exceptions).to receive(:wrap_and_check).and_raise(http_exception)
      end

      it 'returns 400 status code' do
        expect(actual.code).to eq(400)
        expect(actual.body).to eq(body_result)
      end

      it 'calls #capture_error' do
        expect_any_instance_of(described_class).to receive(:capture_error)

        actual
      end
    end

    context 'when error with nobody' do
      let(:actual) { described_class.make_request('get', 'invalid_url') }
      let(:body_result) do
        {
          body: { message: 'An error has occurred while processing response.' },
          code: 503,
        }
      end

      before do
        allow(Http::Exceptions).to receive(:wrap_and_check).and_raise(Http::Exceptions::HttpException)
      end

      it 'returns 503 status code' do
        expect(actual.code).to eq(503)
        expect(actual.body).to eq(body_result)
      end

      it 'calls #capture_error' do
        expect_any_instance_of(described_class).to receive(:capture_error)

        actual
      end
    end

    context 'when send with invalid url' do
      let(:actual) { described_class.make_request('get', 'invalid_url') }
      let(:body_result) do
        {
          body: { message: 'Invalid port number: "80invalid_url"' },
          code: 500,
        }
      end

      it 'returns 500 status code' do
        expect(actual.code).to eq(500)
        expect(actual.body).to eq(body_result)
      end

      it 'calls #capture_error' do
        expect_any_instance_of(described_class).to receive(:capture_error)

        actual
      end
    end
  end

  describe '#capture_error' do
    let(:response) { "\n POST http://api.shoutcloud.io/V1/SHOUT {:headers=>{\"Content-Type\"=>\"application/json\"}, :timeout=>30, :body=>\"{\\\"input\\\":\\\"rspec\\\"}\"}: {:message=>\"message\"}\n" }

    it 'calls Rails.logger' do
      expect(Rails.logger).to receive(:error).with(response)

      described_class.new('post', url, body).send(:capture_error, { message: 'message' })
    end
  end
end
