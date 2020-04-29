# frozen_string_literal: true

module ApiAuthenticable
  AUTHENTICATION_TOKEN_LENGTH = 64

  extend ActiveSupport::Concern

  included do
    before_create do
      self.authentication_token = generate_authentication_token
    end

    def generate_authentication_token
      loop do
        token = Devise.friendly_token(AUTHENTICATION_TOKEN_LENGTH)
        break token unless self.class.find_by(authentication_token: token)
      end
    end

    def valid_token?(provided_token)
      return false unless provided_token

      ActiveSupport::SecurityUtils.secure_compare(
        "Token #{authentication_token}",
        provided_token
      )
    end
  end
end
