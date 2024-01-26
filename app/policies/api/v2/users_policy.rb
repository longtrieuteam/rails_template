# frozen_string_literal: true

module Api
  module V2
    class UsersPolicy < ApplicationPolicy
      def create?
        true
      end

      def update_info?
        true
      end

      def update_password?
        true
      end

      def update_role?
        true
      end

      def forgot_password?
        true
      end

      def reset_password?
        true
      end
    end
  end
end
