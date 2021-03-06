module MyGists
  # Public: Builds an options Hash for MyGists::Fetch.for.
  #
  # Examples
  #
  #   MyGists::Fetch::Options.hash(profile)
  class Fetch::Options

    # Public: Returns the Profile instance received by initializer.
    attr_reader :profile

    # Public: Receives a Profile and returns an options Hash expected by
    #         MyGists::Fetch.for.
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
    # Returns an options Hash.
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
    # Returns an options Hash.
    def to_hash
      {
        username: profile.username,
        token: profile.token,
        since: since
      }
    end

    # Public: Find the last gist updated by profile attribute. If a gist is
    #         found, return its updated timestamp in ISO 8601 format. The
    #         found gist's updated at timestamp is increased by one second,
    #         so it will not be included in response from GitHub API. If a
    #         gist is not found, return nil.
    #
    # Examples
    #
    #   since
    #   # => "2013-01-09T18:04:56Z"
    #
    #   since
    #   # => nil
    #
    # Returns a String timestamp or NilClass.
    def since
      gist = Gist.last_touched_for(profile.id)

      unless gist.blank?
        gist.updated_at.advance(seconds: 1).in_time_zone.strftime("%Y-%m-%dT%H:%M:%SZ")
      end
    end
  end
end
