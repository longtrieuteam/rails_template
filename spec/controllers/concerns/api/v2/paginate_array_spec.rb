# frozen_string_literal: true

require 'rails_helper'

describe Api::V2::PaginateArray do
  describe '#call' do
    let(:collection) { [{ value: 1 }, { value: 2 }] }

    it 'returns 1 object' do
      actual = described_class.call(collection, { page: 1, per_page: 1 })
      expected = {
        data: [{ value: 1 }],
        meta: { count: 1, total_count: 2, total_pages: 2 },
      }

      expect(actual).to eq(expected)
    end
  end
end
