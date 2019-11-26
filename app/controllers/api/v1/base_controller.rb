# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      private

      def require_authentication!
        user = User.find_by(authentication_token: request.headers["X-Api-Key"])

        if user.present?
          sign_in user
        else
          render status: :unauthorized
        end
      end
    end
  end
end
