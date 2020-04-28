# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      private

      def require_authentication!
        id = request.headers["X-User-Id"]
        token = request.headers.fetch("Authorization", "")

        user = User.find_by(id: id)

        if user.present? && valid_token?(user.authentication_token, token)
          sign_in user
        else
          head :unauthorized
        end
      end

      def valid_token?(user_token, provided_token)
        ActiveSupport::SecurityUtils.secure_compare(
          "Token #{user_token}",
          provided_token
        )
      end
    end
  end
end
