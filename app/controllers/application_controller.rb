# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :access_denied

  protected

  def access_denied
    render :access_denied, status: :forbidden
  end
end
