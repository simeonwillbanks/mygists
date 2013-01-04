module MyGists
  class GithubSession

    def self.set_auth(user, auth, opts)
      if auth.session[:github].nil? && !opts[:github].nil?
        auth.session[:github] = opts[:github]
      end
      auth
    end
  end
end
