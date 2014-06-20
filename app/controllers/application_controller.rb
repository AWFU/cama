class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def record_login_redirect_path
    session["user_return_to"] = "#{request.fullpath}"
  end
end
