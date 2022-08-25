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

    return unless request.referer

    Rollbar.warning(
      ["RoutingError: No route matches",
       "[#{request.method}]",
       "'#{request.original_url}'"].join(" ")
    )
  end
end
# rubocop:enable Rails/ApplicationController
