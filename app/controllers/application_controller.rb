class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied, with: :render_error

  def render_not_found
    if request.xhr?
      render json: { status: :not_found }
    else
      render template: 'errors/404', formats: :html, status: :not_found
    end
  end

  def render_error
    if request.xhr?
      render json: { status: :internal_server_error }
    else
      render template: 'errors/500', formats: :html, status: :internal_server_error
    end
  end
end
