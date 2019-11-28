# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      private

      def require_authentication!
        user = authenticate_or_request_with_http_token do |token, _options|
          User.find_by(authentication_token: token)
        end

        if user.present?
          sign_in user
        else
          render status: :unauthorized
        end
      end
    end
  end
end
