# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fullname               :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  otp                    :string
#  password_salt          :string
#  phone                  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :user do
    username { FFaker::Name.unique.first_name }
    fullname { FFaker::Name.unique.last_name }
    email { FFaker::Internet.email }
    phone { "078#{rand(1_000_000..9_999_999)}" }
    password { 'PASSWORD' }

    after(:stub) do |user|
      role_free = build_stubbed(:role_free)

      user.add_role(role_free.name)
    end

    factory :user_with_role_premium, parent: :user do
      after(:stub) do |user|
        role_premium = build_stubbed(:role_premium)

        user.add_role(role_premium.name)
      end
    end
  end
end
