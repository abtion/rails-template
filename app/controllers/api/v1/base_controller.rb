# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      private

      def require_authentication!
        user = User.find(request.headers["X-User-Id"])

        if user.present? && Devise.secure_compare(
          "Token #{user.authentication_token}",
          request.headers["Authorization"]
        )
          sign_in user
        else
          render status: :unauthorized
        end
      end
    end
  end
end
