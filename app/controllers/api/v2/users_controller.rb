# frozen_string_literal: true

module Api
  module V2
    class UsersController < BaseController
      skip_before_action :authenticate_user!, only: %i[create forgot_password reset_password]

      def create
        result = Users::Creator.call(permit_params(__method__))
        raise Error::GatewayError, activerecord_errors_builder(result.errors) unless result.success?

        render json: serialize_resource(resource_serializer, result.resource), status: 201
      end

      def update_info
        result = Users::Updater.call(permit_params(__method__), resource)
        raise Error::GatewayError, activerecord_errors_builder(result.errors) unless result.success?

        render json: serialize_resource(resource_serializer, result.resource), status: 200
      end

      def update_password
        result = Users::PasswordUpdater.call(permit_params(__method__), resource)
        raise Error::GatewayError, activerecord_errors_builder(result.errors) unless result.success?

        render json: serialize_resource(resource_serializer, result.resource), status: 200
      end

      def update_role
        result = Users::RoleUpdater.call(permit_params(__method__), resource)
        raise Error::GatewayError, activerecord_errors_builder(result.errors) unless result.success?

        render json: serialize_resource(resource_serializer, result.resource), status: 200
      end

      def forgot_password
        result = Users::ForgotPassword.call(permit_params(__method__))
        raise Error::GatewayError, activerecord_errors_builder(result.errors) unless result.success?

        render json: { result: 'success' }, status: 200
      end

      def reset_password
        result = Users::ResetPassword.call(permit_params(__method__))
        raise Error::GatewayError, activerecord_errors_builder(result.errors) unless result.success?

        render json: serialize_resource(resource_serializer, result.resource), status: 200
      end

      private

      def resource_serializer
        Api::V2::UserSerializer
      end

      def resource
        current_user
      end

      def permitted_attributes
        {
          create: %i[username email password password_confirmation],
          update_info: %i[fullname],
          update_password: %i[current_password password password_confirmation],
          update_role: %i[role],
          forgot_password: %i[email],
          reset_password: %i[email otp password password_confirmation],
        }
      end

      def permit_params(action)
        params.require(:user).permit(*permitted_attributes[action.to_sym])
      end
    end
  end
end
