# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized
  rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_authenticity_token
  before_action :basic_auth_wall, if: -> { ENV.fetch("HTTP_AUTH_PASSWORD", nil).present? }

  protected

  def not_authorized
    flash[:alert] = t("pundit.not_authorized")
    redirect_to(request.referer || root_path)
  end

  private

  def basic_auth_wall
    authenticate_or_request_with_http_basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(username, ENV.fetch("HTTP_AUTH_USERNAME")) &
        ActiveSupport::SecurityUtils.secure_compare(password, ENV.fetch("HTTP_AUTH_PASSWORD"))
    end
  end

  def after_sign_in_path_for(resource)
    if resource.respond_to?(:pwned?) && resource.pwned?
      set_flash_message!(:warning, :warn_pwned, count: resource.pwned_count)
    end

    super
  end

  def invalid_authenticity_token
    flash[:alert] = t("errors.session_expired")

    redirect_back(fallback_location: root_url)
  end
end
