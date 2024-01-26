# frozen_string_literal: true

module Api
  module V2
    class BaseController < Api::BaseController
      include Api::V2::CollectionOptionsHelpers
      include ::Pundit::Authorization

      before_action :authenticate_user!
      before_action :authorize_user!

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      private

      def authorize_user!
        return if controller_path == 'api/v2/base'

        authorize(controller_path.split('/').map(&:to_sym))
      end

      def current_user
        return if request.headers['X-User-Token'].blank?

        @current_user ||= ::Auth::UserJwtToken.user_from_token(request.headers['X-User-Token'])
      end

      def authenticate_user!
        return if current_user.present?

        render json: error_builder(:user_token, :invalid, 'Unauthenticated'), status: :unauthorized
      end

      def user_not_authorized
        render json: error_builder(:user_token, :invalid, 'Forbidden'), status: :forbidden
      end

      def request_includes
        if params[:include]&.blank?
          []
        elsif params[:include].present?
          params[:include].split(',')
        end
      end

      def resource_includes
        (request_includes || default_resource_includes).map(&:intern)
      end

      # https://jsonapi.org/format/#fetching-includes
      def default_resource_includes
        []
      end

      def serialize_collection(collection_serializer, collection)
        collection_serializer.new(
          collection,
          collection_options(collection)
        ).serializable_hash
      end

      def serialize_resource(resource_serializer, resource)
        resource_serializer.new(
          resource,
          include: resource_includes,
          fields: sparse_fields
        ).serializable_hash
      end

      def collection_options(collection)
        {
          links: collection_links(collection),
          meta: collection_meta(collection),
          include: resource_includes,
          fields: sparse_fields,
        }
      end

      def sparse_fields
        return unless params[:fields].respond_to?(:each)

        fields = {}
        params[:fields]
          .select { |_, v| v.is_a?(String) }
          .each { |type, values| fields[type.intern] = values.split(',').map(&:intern) }
        fields.presence
      end

      def render_serialized_payload(status = 200)
        render(json: yield, status:, content_type:)
      rescue ArgumentError => e
        render_error_payload(e.message, 400)
      end

      def raise_activerecord_errors(errors)
        raise Error::GatewayError, activerecord_errors_builder(errors)
      end
    end
  end
end
