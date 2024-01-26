# frozen_string_literal: true

require 'rails_helper'

describe CoreExt::Range do
  describe '#intersect' do
    current = Time.current
    test_data = [
      { range1: (1..9), range2: (5..14), output: (5..9) },
      { range1: (1..9), range2: (11..14), output: nil },
      {
        range1: (current..current + 3.day),
        range2: (current + 2.day..current + 10.day),
        output: (current + 2.day..current + 3.day),
      },
    ]

    test_data.each do |data|
      context "when #{data[:range1]} intersect with #{data[:range2]}" do
        it "returns #{data[:output]}" do
          actual = data[:range1].intersect(data[:range2])

          expect(actual).to eq(data[:output])
        end
      end
    end
  end

  describe '#intersect?' do
    current = Time.current
    test_data = [
      { range1: (1..9), range2: (5..14), output: true },
      { range1: (1..9), range2: (11..14), output: false },
      {
        range1: (current..current + 3.day),
        range2: (current + 2.day..current + 10.day),
        output: true,
      },
    ]

    test_data.each do |data|
      context "when #{data[:range1]} intersect with #{data[:range2]}" do
        it "returns #{data[:output]}" do
          actual = data[:range1].intersect?(data[:range2])

          expect(actual).to eq(data[:output])
        end
      end
    end
  end

  describe '#distance' do
    current = Time.current
    test_data = [
      { input: (1..9), output: 8 },
      { input: (current.yesterday..current), output: 86_400 },
    ]

    test_data.each do |data|
      context "when input #{data[:input]}" do
        it "returns distance = #{data[:output]}" do
          actual = data[:input].distance

          expect(actual).to eq(data[:output])
        end
      end
    end
  end

  describe '#intersect_array' do
    current = Time.current
    test_data = [
      { range: (3..8), array: [1..4, 5..10, 11..12], output: [3..4, 5..8] },
      {
        range: (current..current + 3.day),
        array: [(current - 2.day)..(current + 1.day), (current + 2.day)..(current + 10.day)],
        output: [current..(current + 1.day), (current + 2.day)..(current + 3.day)],
      },
    ]

    test_data.each do |data|
      context "when #{data[:range]} intersect_array with #{data[:array]}" do
        it "returns #{data[:output]}" do
          actual = data[:range].intersect_array(data[:array])

          expect(actual).to eq(data[:output])
        end
      end
    end
  end
end
