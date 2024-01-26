# frozen_string_literal: true

require 'rails_helper'

describe LocaleSwitcherMiddleware do
  let(:app) { double('app') }
  let(:env) { { 'HTTP_X_LOCALE' => 'en' } }
  subject { described_class.new(app) }

  describe '#user_preferred_locale' do
    before do
      allow(app).to receive(:call).with(env)
    end

    it 'calls methods' do
      is_expected.to receive(:user_preferred_locale).with(env['HTTP_X_LOCALE'])

      subject.call(env)
    end
  end

  describe '#user_preferred_locale' do
    context 'when http_locate is blank' do
      it 'returns I18n.locale' do
        expected = I18n.locale
        actual = subject.send(:user_preferred_locale, '')

        expect(actual).to eq(expected)
      end
    end

    context 'when http_locate is invalid' do
      it 'returns I18n.locale' do
        expected = I18n.locale
        actual = subject.send(:user_preferred_locale, 'invalid')

        expect(actual).to eq(expected)
      end
    end

    context 'when http_locate is valid' do
      it 'returns I18n.locale' do
        expected = :en
        actual = subject.send(:user_preferred_locale, 'en')

        expect(actual).to eq(expected)
      end
    end
  end
end
