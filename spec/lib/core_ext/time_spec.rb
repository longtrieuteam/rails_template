# frozen_string_literal: true

require 'rails_helper'

describe CoreExt::Time do
  describe '#to_timestamp' do
    before do
      Timecop.freeze(Time.current)
    end

    it 'returns timestamp with formatted' do
      expect(Time.current.to_timestamp).to eq(Time.current.strftime('%Y%m%d%H%M%S'))
      expect(Time.now.to_timestamp).to eq(Time.now.strftime('%Y%m%d%H%M%S'))
    end
  end
end
