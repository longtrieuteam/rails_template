# frozen_string_literal: true

require 'rails_helper'

class DummyCollectionOptionsHelpersController < ApplicationController
  include Api::V2::CollectionOptionsHelpers
end

describe Api::V2::CollectionOptionsHelpers do
  subject { DummyCollectionOptionsHelpersController }

  controller(DummyCollectionOptionsHelpersController) do
    def index
      collection = Api::V2::Paginate.call(User.all, params)
      render json: collection_options(collection)
    end

    private

    def collection_options(collection)
      {
        links: collection_links(collection),
        meta: collection_meta(collection),
      }
    end
  end

  before do
    ActionDispatch::Routing::RouteSet.new.tap do |route|
      route.draw { get :index, controller: 'dummy_collection_options_helpers', action: :index }
    end

    allow_any_instance_of(subject).to receive(:url_for).and_return('value')
  end

  describe '#index' do
    let(:result) do
      {
        links: {
          self: 'http://test.host/dummy_collection_options_helpers',
          next: 'value',
          prev: 'value',
          last: 'value',
          first: 'value',
        },
        meta: {
          count: 0,
          total_count: 0,
          total_pages: 0,
        },
      }.to_json
    end

    before { get :index }

    it 'returns result' do
      expect(response.body).to eq(result)
    end
  end
end
