# frozen_string_literal: true

# rubocop:disable Rails/ApplicationController
class ErrorsController < ActionController::Base
  skip_before_action :verify_authenticity_token

  layout "devise"

  def not_found
    respond_to do |format|
      format.html { render status: :not_found }
      format.any { render json: { error: "Page not found" }, status: :not_found }
    end
  end

  def internal_server_error
    respond_to do |format|
      format.html { render status: :internal_server_error }
      format.any { render json: { error: "Internal server error" }, status: :internal_server_error }
    end
  end

  def unprocessable_content
    respond_to do |format|
      format.html { render status: :unprocessable_content }
      format.any { render json: { error: "Unprocessable content" }, status: :unprocessable_content }
    end
  end
end
# rubocop:enable Rails/ApplicationController
