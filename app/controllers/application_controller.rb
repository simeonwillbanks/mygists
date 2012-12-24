class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(user)
    profile_path(user.profile)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to profile_path(current_user.profile), alert: exception.message
  end
end
