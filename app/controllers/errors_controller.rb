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

    return if !request.referer || ignored_route_pattern?

    Rollbar.warning(
      ["RoutingError: No route matches",
       "[#{request.method}]",
       "'#{request.original_url}'"].join(" ")
    )
  end

  private

  def ignored_route_pattern?
    [".php", ".xml", ".txt", ".css", ".zip", ".gz"].any? do |ignored_route_pattern|
      request.path.downcase.include?(ignored_route_pattern)
    end
  end
end
# rubocop:enable Rails/ApplicationController
