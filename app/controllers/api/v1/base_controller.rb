# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      private

      def require_authentication!
        authenticator = Authenticator.new(
          user: User.find_by(id: request.headers["X-User-Id"]),
          provided_token: request.headers["Authorization"]
        )

        if authenticator.valid?
          sign_in authenticator.user
        else
          head :unauthorized
        end
      end

      class Authenticator
        attr_reader :user, :provided_token

        def initialize(user:, provided_token:)
          @user = user
          @provided_token = provided_token
        end

        def valid?
          return false unless user && provided_token

          ActiveSupport::SecurityUtils.secure_compare(
            "Token #{user.authentication_token}",
            provided_token
          )
        end
      end
    end
  end
end
