module MyGists

  # Public: Base class which defines interface for subclasses that
  #         encapsulate all possible Search scopes.
  #
  # Examples
  #
  #   MyGists::Search.Scope::Tags.by(profile: profile, tag_name: tag_name)
  #
  #   MyGists::Search.Scope::Gists.by(profile: profile, tag_name: tag_name)
  class Search::Scope

    # Public: Returns the current ActiveRecord query object.
    attr_reader :scope

    # Public: Returns the Profile from received options.
    attr_reader :profile

    # Public: Returns the String tag name from received options.
    attr_reader :tag_name

    # Public: Based on the received profile and tag name, get the correct
    #         scope to search for gists or tags.
    #
    # Examples
    #
    #   MyGists::Search.Scope::Tags.by(profile: profile, tag_name: tag_name)
    #   # => ActiveRecord::Relation
    #
    #   MyGists::Search.Scope::Gists.by(profile: profile, tag_name: tag_name)
    #   # => ActiveRecord::Relation
    #
    # Returns the current ActiveRecord query object.
    def self.by(options)
      new(options).scope
    end

    # Public: Initialize a Scope.
    #
    # options - The Hash options used to scope the search:
    #           :tag     - String of tag name.
    #           :profile - Profile who owns resources.
    def initialize(options)
      @profile = options.delete(:profile)
      @tag_name = options.delete(:tag_name)
    end

    # Public: Based on the received profile and tag name, get the correct
    #         scope. Each subclass must define the scope permutations.
    #
    # Examples
    #
    #   scope
    #   # => ActiveRecord::Relation
    #
    #   scope
    #   # => ActiveRecord::Relation
    #
    # Returns the current ActiveRecord query object.
    def scope
      if has_profile_tag?
        by_profile_tag
      elsif has_only_profile?
        by_profile
      elsif has_only_tag?
        by_tag
      else
        use_default
      end
    end

    # Public: Template method for scope which includes profile and a tag.
    #
    # Returns nothing.
    # Raises NotImplementedError if the subclass has not defined the method.
    def by_profile_tag
      raise NotImplementedError, "This #{self.class} cannot respond to:"
    end

    # Public: Template method for scope which includes just profile.
    #
    # Returns nothing.
    # Raises NotImplementedError if the subclass has not defined the method.
    def by_profile
      raise NotImplementedError, "This #{self.class} cannot respond to:"
    end

    # Public: Template method for scope which includes just tag.
    #
    # Returns nothing.
    # Raises NotImplementedError if the subclass has not defined the method.
    def by_tag
      raise NotImplementedError, "This #{self.class} cannot respond to:"
    end

    # Public: Template method for a default scope.
    #
    # Returns nothing.
    # Raises NotImplementedError if the subclass has not defined the method.
    def use_default
      raise NotImplementedError, "This #{self.class} cannot respond to:"
    end

    # Public: The profile and tag name attributes both exist, so the scope
    #         includes the profile and its tag.
    #
    # Returns a TrueClass or FalseClass.
    def has_profile_tag?
      profile.present? && tag_name.present?
    end

    # Public: The profile attribute exists, and the tag name does not exist.
    #         The scope only includes the profile.
    #
    # Returns a TrueClass or FalseClass.
    def has_only_profile?
      profile.present? && tag_name.blank?
    end

    # Public: The tag name attribute exists, and the profile does not exist.
    #         The scope only includes the tag.
    #
    # Returns a TrueClass or FalseClass.
    def has_only_tag?
      profile.blank? && tag_name.present?
    end
  end
end
