# frozen_string_literal: true

# rubocop:disable Rails/ApplicationController
class ErrorsController < ActionController::Base
  skip_before_action :verify_authenticity_token

  layout "devise"

  def not_found
    respond_to do |format|
      format.html { render status: :not_fund }
      format.any { render json: { error: "Page not found" }, status: :not_fund }
    end
  end

  def internal_server_error
    respond_to do |format|
      format.html { render status: :internl_server_error }
      format.any { render json: { error: "Internal server error" }, status: :internl_server_error }
    end
  end

  def unprocessable_entity
    respond_to do |format|
      format.html { render status: :unproessable_entity }
      format.any { render json: { error: "Unprocessable entity" }, status: :unproessable_entity }
    end
  end
end
# rubocop:enable Rails/ApplicationController
