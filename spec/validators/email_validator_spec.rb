# frozen_string_literal: true

require 'rails_helper'

class EmailValidatable
  include ActiveModel::Validations
  attr_accessor :email_field

  validates :email_field, email: true
end

describe EmailValidator do
  let(:subject) { EmailValidatable.new }

  describe 'valid email' do
    it 'should be valid' do
      emails = [
        'email@example.com',
        'email+123@example.com',
        'email.test@example.com',
        'email@my-example.com',
        'email@sub.domain.my-example.com',
        'my-email@sub.domain.my-example.com',
        'nicolas@cedrus.digital',
      ]
      emails.each do |email|
        subject.email_field = email

        is_expected.to be_valid
      end
    end
  end

  describe 'invalid email' do
    it 'should be invalid' do
      invalid_emails = [
        'notvalid',
        'example,com',
        'fpt://example.com',
        'email@',
        '@sub.domain.my-example.com',
        'email@example,com',
      ]
      invalid_emails.each do |email|
        subject.email_field = email

        is_expected.to_not be_valid
      end
    end
  end
end
