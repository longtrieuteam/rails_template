# frozen_string_literal: true

# == Schema Information
#
# Table name: user
#
#  id       :string           not null, primary key
#  email    :string           not null
#  role     :string           not null
#  creation :datetime         not null
#
FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    role { 'admin' }
  end
end
