# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :access_denied

  protected

  def access_denied(error)
    render plain: error.message, status: :forbidden
  end
end
