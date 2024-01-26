# frozen_string_literal: true

require 'rails_helper'

class PositiveEpochTimeValidatable
  include ActiveModel::Validations
  attr_accessor :positive_epoch_time

  validates :positive_epoch_time, positive_epoch_time: true
end

describe PositiveEpochTimeValidator do
  let(:subject) { PositiveEpochTimeValidatable.new }

  describe 'valid positive_epoch_time' do
    it 'should be valid' do
      positive_epoch_times = [
        Time.at(1),
        Time.at(1_000_000_000),
      ]

      positive_epoch_times.each do |positive_epoch_time|
        subject.positive_epoch_time = positive_epoch_time

        is_expected.to be_valid
      end
    end
  end

  describe 'invalid positive_epoch_time' do
    it 'should be invalid' do
      invalid_positive_epoch_times = [
        Time.at(0),
        Time.at(-1_000),
      ]

      invalid_positive_epoch_times.each do |positive_epoch_time|
        subject.positive_epoch_time = positive_epoch_time

        is_expected.not_to be_valid
      end
    end
  end
end
