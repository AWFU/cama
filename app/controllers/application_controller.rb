class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

  def record_login_redirect_path
    session["user_return_to"] = "#{request.fullpath}"
  end

  rescue_from CanCan::AccessDenied do |exception|
    #redirect_to root_url, alert: exception.message
    redirect_to :back, alert: exception.message
    # exception.action, exception.subject
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation ,:username, :address, :tel) }
  end

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "admin_sign_in"
    elsif devise_controller? && resource_name == :user
      "devise"
    else
      "application"
    end
  end

  # def after_sign_in_path_for(admin)
  #  authenticated_root_path
  # end
end
