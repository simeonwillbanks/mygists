class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    user = User.find_for_github_oauth(request.env["omniauth.auth"], current_user)

    github = { gravatar: request.env["omniauth.auth"].extra.raw_info.avatar_url }

    sign_in_and_redirect(user, event: :authentication, github: github)

    set_flash_message(:notice, :success, kind: "GitHub")

    flash[:from_omniauth_callback] = true
  end
end
