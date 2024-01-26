# frozen_string_literal: true

require 'rails_helper'

describe ApplicationFinder do
  describe '#unix_time_parser' do
    context 'when unix_time is positive' do
      it 'returns nil' do
        actual = subject.unix_time_parser('1669345071', 'field_name')
        expect(actual).to eq(Time.at(1_669_345_071))
      end
    end

    context 'when unix_time is negative' do
      let(:errors) do
        {
          details: { field_name: [{ error: 'invalid', value: nil }] },
          error: 'Field Name  ',
          errors: { field_name: [' '] },
        }.to_json
      end

      before do
        allow(subject).to receive(:message).and_return(' ')
      end

      it 'returns errors' do
        expect do
          subject.unix_time_parser('-1', 'field_name')
        end.to raise_exception(Error::GatewayError, errors)
      end
    end
  end
end
