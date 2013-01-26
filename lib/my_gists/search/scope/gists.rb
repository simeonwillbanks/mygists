module MyGists

  # Public: Encapsulate all possible scopes for searching gists.
  #
  # Examples
  #
  #   MyGists::Search.Scope::Gists.by(profile: profile, tag_name: tag_name)
  class Search::Scope::Gists < Search::Scope

    # Public: Scope which includes profile and a tag.
    #
    # Returns the ActiveRecord query object.
    def by_profile_tag
      profile.gists.tagged_with(tag_name)
    end

    # Public: Scoped to just a profile.
    #
    # Returns the ActiveRecord query object.
    def by_profile
      profile.gists
    end

    # Public: Scoped to just a tag.
    #
    # Returns the ActiveRecord query object.
    def by_tag
      Gist.tagged_with(tag_name).includes(:profile)
    end

    # Public: The default scope.
    #
    # Returns the ActiveRecord query object.
    def use_default
      Gist.scoped.includes(:profile)
    end
  end
end
