# frozen_string_literal: true

require 'rails_helper'

describe Error::ExceptionErrorBuilder do
  include described_class

  describe '#error_builder' do
    let(:result) do
      {
        details: {
          topic_name: [{ error: 'invalid', value: nil }],
        },
        error: 'Topic Name error message',
        errors: {
          topic_name: ['error message'],
        },
      }.to_json
    end

    it 'returns result' do
      actual = error_builder(:topic_name, :invalid, 'error message')

      expect(actual).to eq(result)
    end
  end

  describe '#activerecord_errors_builder' do
    context 'when error is a ActiveModel::Errors' do
      let(:errors) do
        {
          details: 'details',
          messages: { values: %w[v1 v2] },
        }.to_mash
      end

      let(:result) do
        {
          details: 'details',
          error: 'v1 v2',
          errors: { values: %w[v1 v2] },
        }.to_json
      end

      before do
        allow(errors).to receive(:is_a?).and_return(ActiveModel::Errors)
      end

      it 'returns error message' do
        expect(activerecord_errors_builder(errors)).to eq(result)
      end
    end

    context 'when error is blank' do
      let(:errors) { '' }

      it 'returns blank' do
        expect(activerecord_errors_builder(errors)).to be_blank
      end
    end

    context 'when error is not a ActiveModel::Errors' do
      let(:errors) { 'errors content' }

      it 'returns content of errors' do
        expect(activerecord_errors_builder(errors)).to eq(errors)
      end
    end
  end

  describe '#error_message' do
    it 'returns messages' do
      actual = error_message(:field)
      expected = {
        success?: false,
        errors: { details: { field: [{ error: 'invalid', value: nil }] },
                  error: 'Field invalid',
                  errors: { field: ['invalid'] }, }.to_json,
      }

      expect(actual.to_json).to eq(expected.to_json)
    end
  end
end
