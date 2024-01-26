# frozen_string_literal: true

require 'rails_helper'

class PhoneValidatable
  include ActiveModel::Validations
  attr_accessor :phone

  validates :phone, phone: true
end

describe PhoneValidator do
  let(:subject) { PhoneValidatable.new }

  describe 'valid phone' do
    it 'should be valid' do
      phones = [
        '+84785288888',
        '+840785288888',
        '84785288888',
        '840785288888',
      ]

      phones.each do |phone|
        subject.phone = phone

        is_expected.to be_valid
      end
    end
  end

  describe 'invalid phone' do
    it 'should be invalid' do
      invalid_phones = [
        '+83785288888',
        '40785288888',
        '84785288888123',
        'abc',
      ]

      invalid_phones.each do |phone|
        subject.phone = phone

        is_expected.not_to be_valid
      end
    end
  end
end
