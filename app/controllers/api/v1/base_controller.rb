# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      private

      def require_authentication!
        id = request.headers["X-User-Id"]

        user = User.find_by(id: id)

        if user.present? && valid_token?(user.authentication_token)
          sign_in user
        else
          head :unauthorized
        end
      end

      def valid_token?(token)
        ActiveSupport::SecurityUtils.secure_compare(
          "Token #{token}",
          token_from_headers
        )
      end

      def token_from_headers
        request.headers.fetch("Authorization", "")
      end
    end
  end
end
