# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :access_denied
  before_action :basic_auth_wall, if: -> { ENV.fetch("HTTP_AUTH_PASSWORD", nil).present? }

  protected

  def access_denied(error)
    render plain: error.message, status: :forbidden
  end

  private

  def basic_auth_wall
    authenticate_or_request_with_http_basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(username, ENV.fetch("HTTP_AUTH_USERNAME")) &
        ActiveSupport::SecurityUtils.secure_compare(password, ENV.fetch("HTTP_AUTH_PASSWORD"))
    end
  end
end
