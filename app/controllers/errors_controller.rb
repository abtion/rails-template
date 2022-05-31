# frozen_string_literal: true

# rubocop:disable Rails/ApplicationController
class ErrorsController < ActionController::Base
  skip_before_action :verify_authenticity_token

  layout "devise"

  def not_found
    render status: :not_found

    return unless request.referer

    Rollbar.warning(
      ["RoutingError: No route matches",
       "[#{request.method}]",
       "'#{request.original_url}'"].join(" ")
    )
  end
end
# rubocop:enable Rails/ApplicationController
