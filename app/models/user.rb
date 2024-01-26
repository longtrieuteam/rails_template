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
class User < ApplicationRecord
  rolify
  include Utils::I18n
  rolify before_add: :before_add_role

  devise :database_authenticatable, :trackable, :encryptable, encryptor: :authlogic_sha512

  validates :username, uniqueness: { case_sensitive: false }, presence: true
  validates :fullname, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates_length_of :password, in: 8..20

  after_create :assign_default_role

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at email username fullname phone updated_at password_salt]
  end

  def generate_token
    Auth::UserJwtToken.generate_token_for(self)
  end

  def role_name
    roles.first&.name
  end

  private

  def assign_default_role
    add_role(:free) if roles.blank?
  end

  def before_add_role(_role)
    self.roles = []
  end
end
