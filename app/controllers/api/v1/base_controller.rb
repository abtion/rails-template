# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      private

      def require_authentication!
        user = find_user

        if user.present? && valid_token?(user.authentication_token)
          sign_in user
        else
          render json: {}, status: :unauthorized
        end
      end

      def find_user
        User.find_by(id: user_id_from_headers)
      end

      def valid_token?(token)
        return unless token && token_from_headers

        ActiveSupport::SecurityUtils.secure_compare(
          "Token #{token}",
          token_from_headers
        )
      end

      def user_id_from_headers
        request.headers["X-User-Id"]
      end

      def token_from_headers
        request.headers["Authorization"]
      end
    end
  end
end
