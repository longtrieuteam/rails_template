# frozen_string_literal: true

module Api
  module V2
    class UserSerializer < BaseSerializer
      attributes :email, :username, :fullname, :phone
      attribute :role do |user|
        user.roles.first.name
      end
    end
  end
end
