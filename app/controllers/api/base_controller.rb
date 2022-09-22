# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token

    private

    def require_authentication!
      user = User.find_by(id: request.headers["X-User-Id"])

      if user&.valid_token?(request.headers["Authorization"])
        sign_in(user)
      else
        head(:unauthorized)
      end
    end
  end
end
