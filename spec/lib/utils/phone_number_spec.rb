# frozen_string_literal: true

require 'rails_helper'

describe Utils::PhoneNumber do
  describe '#vietnamese_phone?' do
    phone_numbers = {
      '+84785288888': true,
      '+840785288888': true,
      '84785288888': true,
      '840785288888': true,
      '07852888888': false,
      '7avc85288888': false,
    }

    phone_numbers.each do |phone, result|
      context "when phone number is #{phone}" do
        it "returns #{result}" do
          actual = described_class.new(phone:).vietnamese_phone?

          expect(actual).to eq(result)
        end
      end
    end
  end

  describe '#phone_without_country_prefix' do
    countries_prefix = %w[+840 +84 840 84]

    countries_prefix.each do |prefix|
      context "when country prefix is #{prefix}" do
        it 'returns 0' do
          actual = described_class.new(phone: prefix).phone_without_country_prefix

          expect(actual).to eq('0')
        end
      end
    end
  end

  describe '#present?' do
    context 'when phone number is present' do
      it 'returns true' do
        actual = described_class.new(phone: '840785288888').present?

        expect(actual).to eq(true)
      end
    end

    context 'when phone number is not present' do
      it 'returns false' do
        actual = described_class.new(phone: nil).present?

        expect(actual).to eq(false)
      end
    end
  end

  describe '#blank?' do
    context 'when phone number is blank' do
      it 'returns true' do
        actual = described_class.new(phone: '').blank?

        expect(actual).to eq(true)
      end
    end

    context 'when phone number is not blank' do
      it 'returns false' do
        actual = described_class.new(phone: '840785288888').blank?

        expect(actual).to eq(false)
      end
    end
  end
end
