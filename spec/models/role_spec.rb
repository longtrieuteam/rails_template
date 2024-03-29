# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id            :uuid             not null, primary key
#  name          :string
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :uuid
#
# Indexes
#
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#  index_roles_on_resource                                (resource_type,resource_id)
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  it { expect(Role::WHITELIST_ROLES).to eq(%w[free premium].freeze) }
  it { is_expected.to have_and_belong_to_many(:users).join_table(:users_roles) }
  it { is_expected.to validate_inclusion_of(:name).in_array(Role::WHITELIST_ROLES) }
end
