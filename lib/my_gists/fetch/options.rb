module MyGists
  # Public: Builds a options Hash for MyGists::Fetch.for.
  #
  # Examples
  #
  #   MyGists::Fetch::Options.hash(profile)
  class Fetch::Options

    # Public: Returns the Profile profile of Fetch::Options.
    attr_reader :profile

    # Public: Receives a Profile and returns an options Hash expected by
    #         MyGists::Fetch.for
    #
    # profile - An instance of Profile.
    #
    # Examples
    #
    #   MyGists::Fetch::Options.hash(profile)
    #   # => { username: "sw", token: "7bfdda", since: "2013-01-09T18:04:56Z" }
    #
    #   MyGists::Fetch::Options.hash(profile)
    #   # => { username: "foo", token: "7bfdda", since: nil }
    #
    # Returns An options Hash.
    def self.hash(profile)
      new(profile).to_hash
    end

    # Public: Initialize a Fetch::Options.
    #
    # profile - An instance of Profile.
    def initialize(profile)
      @profile = profile
    end

    # Public: Follows Ruby #to_hash convention, and returns a Hash
    #         representation of self from object attributes.
    #
    # Examples
    #
    #   to_hash
    #   # => { username: "sw", token: "7bfdda", since: "2013-01-09T18:04:56Z" }
    #
    #   to_hash
    #   # => { username: "foo", token: "7bfdda", since: nil }
    #
    # Returns An options Hash.
    def to_hash
      {
        username: profile.username,
        token: profile.token,
        since: since
      }
    end

    # Public: If a profile's gists are filterable, return a timestamp for
    #         filtering. If the gists are not filterable, return nil.
    #
    # Examples
    #
    #   since
    #   # => "2013-01-09T18:04:56Z"
    #
    #   since
    #   # => nil
    #
    # Returns A String timestamp or NilClass.
    def since
      filterable? ? timestamp : nil
    end

    # Public: Once a profile's gists have been set to public or private, a
    #         profile will have no gists with public set to NULL, and fetching
    #         gists can be filtered by a timestamp.
    #
    # Examples
    #
    #   filterable?
    #   # => true
    #
    #   filterable?
    #   # => false
    #
    # Returns A TrueClass or FalseClass.
    def filterable?
      Gist.public_null_for(profile.id).blank?
    end

    # Public: Find the last gist updated by profile attribute. If a gist is
    #         found, return its updated timestamp in ISO 8601 format. If a
    #         gist is not found, return nil.
    #
    #   timestamp
    #   # => "2013-01-09T18:04:56Z"
    #
    #   timestamp
    #   # => nil
    #
    # Returns A String timestamp or NilClass.
    def timestamp
      gist = Gist.last_touched_for(profile.id)

      unless gist.blank?
        gist.updated_at.in_time_zone.strftime("%Y-%m-%dT%H:%M:%SZ")
      end
    end
  end
end
