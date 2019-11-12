class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :access_denied

  protected

  def access_denied
    render :access_denied, status: 403
  end
end
