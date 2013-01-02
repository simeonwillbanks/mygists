module MyGists
  class Fetch::Options
    attr_reader :profile

    class << self
      def hash(profile)
        new(profile).to_hash
      end
    end

    def initialize(profile)
      @profile = profile
    end

    def to_hash
      {
        username: profile.username,
        token: profile.token,
        since: since
      }
    end

    def since
      filterable? ? timestamp : nil
    end

    def filterable?
      # Once a profiles gists have been set to public or private,
      # a profile will have no gists with public set to NULL,
      # and fetching gists can be filtered by a timestamp.
      Gist.public_null_for(profile.id).blank?
    end

    def timestamp
      gist = Gist.last_touched_for(profile.id)
      unless gist.blank?
        gist.updated_at.in_time_zone.strftime('%Y-%m-%dT%H:%M:%SZ')
      end
    end
  end
end
