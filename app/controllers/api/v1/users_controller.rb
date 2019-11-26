# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      before_action :require_authentication!

      def show
        render json: UserSerializer.new(current_user).serializable_hash
      end
    end
  end
end
