class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # Public: OmniAuth callback implemented as an action with the same name as
  #         the provider (github). All information retrieved from GitHub by
  #         OmniAuth is available as a hash at request.env["omniauth.auth"].
  #         In case a valid user is given from our model, we should sign it in.
  #         We set a flash message using one of Devise's default messages.
  #         Also, we get GitHub session key/value pairs from request, and we
  #         set those key/value pairs in the MyGists session. At this time, we
  #         no longer need any GitHub session members, but we've kept the
  #         infrastructure in place for the future. Next, we sign the user in
  #         and redirect it. Flash messages are set for successful sign in and
  #         that the request came from this callback.
  #         https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
  #
  # Returns nothing.
  def github
    user = User.find_for_github_oauth(request.env["omniauth.auth"], current_user)

    github = { }

    sign_in_and_redirect(user, event: :authentication, github: github)

    set_flash_message(:notice, :success, kind: "GitHub")

    flash[:from_omniauth_callback] = true
  end
end
