module MyGists

  # Public: Encapsulate all possible scopes for searching tags.
  #
  # Examples
  #
  #   MyGists::Search.Scope::Tags.by(profile: profile, tag_name: tag_name)
  class Search::Scope::Tags < Search::Scope

    # Public: Scoped to a profile's tag.
    #
    # Returns the ActiveRecord query object.
    def by_profile_tag
      profile.owned_tags.by_name(tag_name)
    end

    # Public: Scoped to just a profile.
    #
    # Returns the ActiveRecord query object.
    def by_profile
      profile.owned_tags.ordered_by_slug
    end

    # Public: Scoped to just a tag.
    #
    # Returns the ActiveRecord query object.
    def by_tag
      ActsAsTaggableOn::Tag.by_name(tag_name)
    end

    # Public: The default scope.
    #
    # Returns the ActiveRecord query object.
    def use_default
      ActsAsTaggableOn::Tag.scoped.ordered_by_slug
    end
  end
end
