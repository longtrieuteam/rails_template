# frozen_string_literal: true

require 'rails_helper'

class DummyApiV2BaseController < Api::V2::BaseController; end

describe Api::V2::BaseController do
  let(:user) { build_stubbed(:user) }

  before do
    ActionDispatch::Routing::RouteSet.new.tap do |route|
      route.draw { get :index, controller: 'api/v2/base', action: :index }
    end
  end

  let(:dummy_base_controller) { DummyApiV2BaseController.new }

  controller(described_class) do
    def index
      render json: { users: [] }
    end
  end

  describe '#authorize_user!' do
    it 'calls authorize' do
      expect_any_instance_of(DummyApiV2BaseController).to receive(:authorize).with([:dummy_api_v2_base])

      dummy_base_controller.send(:authorize_user!)
    end
  end

  describe 'request' do
    context 'with no headers' do
      before { get :index }

      it_behaves_like 'returns 401 status'
    end

    context 'with valid headers' do
      before do
        allow(Auth::UserJwtToken).to receive(:user_from_token).and_return(user)
        request.headers['X-User-Token'] = 'valid_token'

        get :index
      end

      it_behaves_like 'returns 200 status'
    end
  end

  describe '#resource_includes' do
    context 'when has include params' do
      before do
        dummy_base_controller.params = { include: 'variants,images,taxons' }
      end

      it 'returns resources' do
        expect(dummy_base_controller.send(:resource_includes)).to eq(%i[variants images taxons])
      end
    end

    context 'when params is blank' do
      before do
        dummy_base_controller.params = {}
      end

      it 'returns empty array' do
        expect(dummy_base_controller.send(:resource_includes)).to eq([])
      end
    end

    context 'when include params is blank' do
      before do
        dummy_base_controller.params = { include: '' }
      end

      it 'returns empty array' do
        expect(dummy_base_controller.send(:resource_includes)).to eq([])
      end
    end
  end

  describe '#collection_options' do
    before do
      allow_any_instance_of(described_class).to receive(:collection_links).and_return('value')
      allow_any_instance_of(described_class).to receive(:collection_meta).and_return('value')
      allow_any_instance_of(described_class).to receive(:resource_includes).and_return('value')
      allow_any_instance_of(described_class).to receive(:sparse_fields).and_return('value')
    end

    let(:result) { { fields: 'value', include: 'value', links: 'value', meta: 'value' } }

    it 'returns result' do
      expect(dummy_base_controller.send(:collection_options, 'collection')).to eq(result)
    end
  end

  describe '#sparse_fields' do
    shared_examples 'invalid params format' do
      it 'returns nil' do
        expect(dummy_base_controller.send(:sparse_fields)).to be_nil
      end
    end

    context 'when params is blank' do
      before do
        dummy_base_controller.params = {}
      end

      it_behaves_like 'invalid params format'
    end

    context 'with no field type specified' do
      before do
        dummy_base_controller.params = { fields: 'name,slug,price' }
      end

      it_behaves_like 'invalid params format'
    end

    context 'with type values not comma separated' do
      before do
        dummy_base_controller.params = { fields: { product: { values: 'name,slug,price' } } }
      end

      it_behaves_like 'invalid params format'
    end

    context 'with valid params format' do
      before do
        dummy_base_controller.params = { fields: { product: 'name,slug,price' } }
      end

      it 'returns specified params' do
        expect(dummy_base_controller.send(:sparse_fields)).to eq(product: %i[name slug price])
      end
    end
  end

  describe '#render_serialized_payload' do
    controller(described_class) do
      def index
        render_serialized_payload { raise ArgumentError, 'error' }
      end
    end

    before do
      allow(Auth::UserJwtToken).to receive(:user_from_token).and_return(user)
      request.headers['X-User-Token'] = 'valid_token'

      get :index
    end

    let(:result) { 'error' }

    it 'returns result' do
      expect(response.body).to eq(result)
    end
  end

  describe '#raise_activerecord_errors' do
    it 'raise exceptions' do
      expect do
        subject.send(:raise_activerecord_errors, {})
      end.to raise_error(Error::GatewayError, '{}')
    end
  end
end
