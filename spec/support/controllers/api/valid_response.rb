# frozen_string_literal: true

require 'rails_helper'

shared_examples 'returns 200 status' do
  it 'returns response' do
    json = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(json).to_not be_nil
  end
end

shared_examples 'returns 404 status' do
  it 'returns response' do
    json = JSON.parse(response.body)
    expect(response.status).to eq(404)
    expect(json).to_not be_nil
  end
end

shared_examples 'returns 422 status' do
  it 'returns response' do
    json = JSON.parse(response.body)
    expect(response.status).to eq(422)
    expect(json).to_not be_nil
  end
end

shared_examples 'returns 401 status' do
  it 'returns response' do
    json = JSON.parse(response.body)
    expect(response.status).to eq(401)
    expect(json).to_not be_nil
  end
end

shared_examples 'returns 400 status' do
  it 'returns response' do
    json = JSON.parse(response.body)
    expect(response.status).to eq(400)
    expect(json).to_not be_nil
  end
end

shared_examples 'returns 201 status' do
  it 'returns response' do
    json = JSON.parse(response.body)
    expect(response.status).to eq(201)
    expect(json).to_not be_nil
  end
end

shared_examples 'returns 110 status' do
  it 'returns response' do
    json = JSON.parse(response.body)
    expect(response.status).to eq(110)
    expect(json).to_not be_nil
  end
end

shared_examples 'returns 120 status' do
  it 'returns response' do
    json = JSON.parse(response.body)
    expect(response.status).to eq(120)
    expect(json).to_not be_nil
  end
end
