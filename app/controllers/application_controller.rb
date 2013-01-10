class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_new_relic_custom_parameters

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to profile_path(current_user.profile), alert: exception.message
  end

  # Public: Url helper for a new session. When a new session fails to be
  #         created, the user should be redirected to the home page.
  #         Devise::OmniauthCallbacksController#after_omniauth_failure_path_for
  #         sends a message to .new_session_path which is route Devise no
  #         longer sets. Therefore, we need to define the helper until the
  #         Devise::OmniauthCallbacksController is refactored.
  #         TODO: Remove new_session_path helper.
  #
  # scope - Devise specific resource scope.
  #
  # Returns a String url path.
  helper_method :new_session_path
  def new_session_path(scope)
    root_path
  end

  protected
  # Internal: New Relic allows you to collect standard HTTP parameters, as
  #           well as custom parameters, with every transaction trace,
  #           browser trace, and error. For MyGists, we track the current
  #           user, their user agent and IP address as custom parameters.
  #
  # Returns nothing.
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
end
