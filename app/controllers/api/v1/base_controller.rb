# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      private

      def require_authentication!
        user = User.find_by(id: request.headers["X-User-Id"]) || NullUser.new

        if user.valid_token?(request.headers["Authorization"])
          sign_in user
        else
          head :unauthorized
        end
      end

      class NullUser
        def valid_token?(_token)
          false
        end
      end
    end
  end
end
