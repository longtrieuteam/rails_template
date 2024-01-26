# frozen_string_literal: true

require 'rails_helper'

describe 'routing users' do
  let(:controller) { 'api/v2/users' }

  it 'routes to #index' do
    expect(get: '/api/v2/users').not_to route_to(controller:, action: 'index')
  end

  it 'routes to #new' do
    expect(get: '/api/v2/users/new').not_to route_to(controller:, action: 'new')
  end

  it 'routes to #show' do
    expect(get: '/api/v2/users/1').not_to route_to(controller:, action: 'show', id: '1')
  end

  it 'routes to #edit' do
    expect(get: '/api/v2/users/1/edit').not_to route_to(controller:, action: 'edit', id: '1')
  end

  it 'routes to #create' do
    expect(post: '/api/v2/users').to route_to(controller:, action: 'create')
  end

  it 'routes to #update via PUT' do
    expect(put: '/api/v2/users/1').not_to route_to(controller:, action: 'update', id: '1')
  end

  it 'routes to #update via PATCH' do
    expect(patch: '/api/v2/users/1').not_to route_to(controller:, action: 'update', id: '1')
  end

  it 'routes to #destroy' do
    expect(delete: '/api/v2/users/1').not_to route_to(controller:, action: 'destroy', id: '1')
  end

  it 'routes to #update_password' do
    expect(put: '/api/v2/users/update_password').to route_to(controller:, action: 'update_password')
  end

  it 'routes to #forgot_password' do
    expect(post: '/api/v2/users/forgot_password').to route_to(controller:, action: 'forgot_password')
  end

  it 'routes to #reset_password' do
    expect(post: '/api/v2/users/reset_password').to route_to(controller:, action: 'reset_password')
  end
end
