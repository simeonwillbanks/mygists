class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    user = User.find_for_github_oauth(request.env['omniauth.auth'], current_user)
    sign_in_and_redirect(user, :event => :authentication, :github => {:gravatar => request.env['omniauth.auth']['info']['image'], :token => request.env['omniauth.auth']['credentials']['token']})
    set_flash_message(:notice, :success, :kind => 'GitHub')
  end
end
