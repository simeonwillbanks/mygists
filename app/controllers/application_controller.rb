class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(user)
    profile_path(user.profile)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to profile_path(current_user.profile), alert: exception.message
  end

  # TODO
  # remove new_session_path helper
  # @see Devise::OmniauthCallbacksController#after_omniauth_failure_path_for
  # It expects new_session_path helper to be defined
  helper_method :new_session_path
  def new_session_path(scope)
    # A new session is created by signing in with GitHub on home page
    root_path
  end
end
