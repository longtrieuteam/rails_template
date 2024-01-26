# frozen_string_literal: true

require 'rails_helper'

describe CoreExt::Object do
  describe '#numeric?' do
    test_data = [
      { input: '42', output: true },
      { input: '-42', output: true },
      { input: '1.2', output: true },
      { input: '0', output: true },
      { input: '1.2e34', output: true },
      { input: '1_000', output: true },
      { input: '', output: false },
      { input: ' ', output: false },
      { input: 'a', output: false },
      { input: '-', output: false },
      { input: '.', output: false },
      { input: '_', output: false },
      { input: '1.2.3', output: false },
      { input: '1,000', output: false },
      { input: '1,000,000', output: false },
    ]

    test_data.each do |data|
      context "when input is #{data[:input]}" do
        it "returns #{data[:output]}" do
          actual = data[:input].numeric?

          expect(actual).to eq(data[:output])
        end
      end
    end
  end
end
