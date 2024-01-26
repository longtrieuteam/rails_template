# frozen_string_literal: true

module Api
  module V2
    module Auth
      class TokenController < Api::V2::BaseController
        skip_before_action :authenticate_user!, only: :create
        skip_before_action :authorize_user!

        def create
          if user
            render json: user.generate_token, status: :created
          else
            render json: error_builder(:username_or_password, :invalid, 'invalid'), status: :unauthorized
          end
        end

        def refresh
          render json: current_user.generate_token, status: :ok
        end

        def profile
          render json: serialize_resource(resource_serializer, current_user)
        end

        private

        def resource_serializer
          UserSerializer
        end

        def user
          @user ||= Users::Finder.find_by_username_and_password(token_params)
        end

        def token_params
          params.permit(:username, :password)
        end
      end
    end
  end
end
