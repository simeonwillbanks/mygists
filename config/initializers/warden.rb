Warden::Manager.after_set_user do |user, auth, opts|
  if auth.session[:github].nil? && !opts[:github].nil?
    auth.session[:github] = opts[:github]
  end
end
