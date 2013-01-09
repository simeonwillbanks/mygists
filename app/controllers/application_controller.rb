class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_new_relic_custom_parameters

  def set_new_relic_custom_parameters
    return unless defined?(NewRelic)

    custom_params = {
      user_id:          0,
      profile_username: "anonymous",
      user_agent:       request.env["HTTP_USER_AGENT"],
      remote_ip:        request.remote_ip
    }

    if user_signed_in?
      custom_params.merge!(user_id: current_user.id,
                           profile_username: current_user.profile.username)
    end

    NewRelic::Agent.add_custom_parameters(custom_params)
  end

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
