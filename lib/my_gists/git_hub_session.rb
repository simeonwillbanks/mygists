module MyGists

  # Public: Adds GitHub session key/value pairs to MyGists session.
  class GitHubSession

    # Public: Adds GitHub session key/value pairs to MyGists session. Should be
    #         called within a Warden::Manager.after_set_user block. See Warden
    #         initializer.
    #
    # user - The user object that is being set.
    # auth - The raw authentication proxy object.
    # opts - Any options passed into the set_user call including :scope.
    #
    # Examples
    #
    #   Warden::Manager.after_set_user do |user, auth, opts|
    #     auth = MyGists::GitHubSession.set_auth(user, auth, opts)
    #   end
    #
    # Returns a raw authentication proxy object.
    def self.set_auth(user, auth, opts)
      if auth.session[:github].nil? && !opts[:github].nil?
        auth.session[:github] = opts[:github]
      end
      auth
    end
  end
end
