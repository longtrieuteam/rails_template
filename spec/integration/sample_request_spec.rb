# frozen_string_literal: true

require 'rails_helper'

describe 'sample_request' do
  context 'when get api to dummyjson.com' do
    it 'returns 200 status code' do
      VCR.use_cassette('when get api to dummyjson.com') do
        data = {}
        url = 'https://dummyjson.com/todos'
        response = HTTParty.send(:get, url, data)

        expect(response.code).to eq(200)
      end
    end
  end
end
