# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    include Error::ExceptionErrorBuilder
    skip_before_action :verify_authenticity_token

    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::ParameterMissing, with: :bad_request
    rescue_from Error::GatewayError, with: :gateway_error

    private

    def not_found
      render json: error_builder(:record, :invalid, 'Not Found'), status: :not_found
    end

    def bad_request
      render json: error_builder(:params, :invalid, 'Invalid'), status: :bad_request
    end

    def gateway_error(exception)
      render_error_payload(exception.message)
    end

    def render_error_payload(error, status = 422)
      render json: error, status:, content_type:
    end
  end
end
