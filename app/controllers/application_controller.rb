# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :access_denied
  before_action :basic_auth_wall, if: -> { ENV["HTTP_AUTH_PASSWORD"].present? }

  protected

  def access_denied(error)
    render plain: error.message, status: :forbidden
  end

  private

  def basic_auth_wall
    authenticate_or_request_with_http_basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(username, ENV["HTTP_AUTH_USERNAME"]) &
        ActiveSupport::SecurityUtils.secure_compare(password, ENV["HTTP_AUTH_PASSWORD"])
    end
  end
end
