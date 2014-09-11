class AdminController < ApplicationController
  before_action :authenticate_admin!
  authorize_resource
  before_action :current_ability

  layout "admin"

  rescue_from CanCan::AccessDenied do |exception|
    #redirect_to root_url, alert: exception.message
    
    redirect_to '/404.html', alert: exception.message
    # exception.action, exception.subject
    
  end

  private

  def current_ability
    @current_ability ||= AdminAbility.new(current_admin)
  end

  def after_sign_out_path_for(current_admin)
    root_path
  end

end
