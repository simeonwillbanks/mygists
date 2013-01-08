Warden::Manager.after_set_user do |user, auth, opts|
  auth = MyGists::GithubSession.set_auth(user, auth, opts)
end
