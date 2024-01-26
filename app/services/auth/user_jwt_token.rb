# frozen_string_literal: true

module Auth
  class UserJwtToken
    attr_reader :token

    class << self
      def generate_token_for(user)
        new(nil).encode(user)
      end

      def user_from_token(token)
        new(token).user
      end
    end

    def initialize(token)
      @token = token
    end

    def encode(user)
      return {} unless user_encoding_valid?(user)

      payload_data = { user_id: user.id, password_salt: user.password_salt, token_generated_at: Time.current.to_i }
      jwt_token = JWT.encode(payload_data, hmac_secret, algorithm)

      {
        role: user.role_name,
        token: jwt_token,
        expired_at: expired_time.to_i.seconds.from_now,
      }
    end

    def user
      return unless valid?

      payload_user
    end

    private

    def valid?
      !expired? && payload_user.present? && password_salt_matched?
    end

    def expired?
      (Time.current.to_i - token_generated_at) > expired_time
    end

    def password_salt_matched?
      payload_user.password_salt == payload[:password_salt]
    end

    def token_generated_at
      payload[:token_generated_at].to_i
    end

    def payload
      @payload ||=
        begin
          JWT.decode(token, hmac_secret, true, algorithm:).first&.symbolize_keys
        rescue => _e
          {}
        end
    end

    def payload_user
      return if payload[:user_id].blank?

      @payload_user ||= User.find_by(id: payload[:user_id])
    end

    def user_encoding_valid?(user)
      return false unless user.is_a?(User)
      return false unless user.persisted?

      true
    end

    def hmac_secret
      ENV.fetch('JWT_HMAC_SECRET')
    end

    def algorithm
      ENV.fetch('JWT_ALGORITHM')
    end

    def expired_time
      ENV.fetch('JWT_EXPIRED_TIME').to_i
    end
  end
end
