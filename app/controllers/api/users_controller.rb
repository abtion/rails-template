# frozen_string_literal: true

module Api
  class UsersController < Api::BaseController
    before_action :require_authentication!

    def show
      render json: UserSerializer.new(current_user).serializable_hash
    end
  end
end
