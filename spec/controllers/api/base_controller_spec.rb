# frozen_string_literal: true

require 'rails_helper'

describe Api::BaseController do
  before do
    ActionDispatch::Routing::RouteSet.new.tap do |route|
      route.draw { get :index, controller: 'api/base', action: :index }
      route.draw { post :create, controller: 'api/base', action: :create }
    end
  end

  context 'when get ActiveRecord::RecordNotFound' do
    controller(described_class) do
      def index
        raise ActiveRecord::RecordNotFound
      end
    end

    before { get :index }

    it_behaves_like 'returns 404 status'
  end

  context 'when get ActionController::ParameterMissing' do
    controller(described_class) do
      def create
        raise ActionController::ParameterMissing.new(params: {})
      end
    end

    before { post(:create) }

    it_behaves_like 'returns 400 status'
  end

  context 'when get Error::GatewayError' do
    controller(described_class) do
      def index
        raise Error::GatewayError, error_builder(:resource, :invalid, 'invalid')
      end
    end

    before { get :index }

    it_behaves_like 'returns 422 status'
  end
end
