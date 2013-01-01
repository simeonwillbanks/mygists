module MyGists
  class Refresh

    class << self
      protected :new

      def for(profile)
        new(profile) do
          refresh
        end
      end
    end

    def initialize(profile, &block)
      @profile = profile
      instance_eval(&block) if block_given?
    end

    private

    attr_reader :profile, :fetched_gist, :gist

    def refresh
      gists.each do |fetched_gist|
        @fetched_gist = fetched_gist
        save_gist
        tag_gist
      end
    end

    def gists
      MyGists::Fetch.for(MyGists::Fetch::Options.hash(profile))
    end

    def gid
      fetched_gist['id']
    end

    def save_gist
      @gist = Gist.find_or_create_by_profile_id_and_gid(profile.id, gid).tap do |g|
        g.description = fetched_gist['description']
        g.created_at = fetched_gist['created_at']
        g.updated_at = fetched_gist['updated_at']
        g.public = fetched_gist['public']
        g.starred = fetched_gist['starred']
        g.save!
      end
    end

    def tag_gist
      profile.tag(gist, with: MyGists::Tags.for(gist), on: :descriptions)
    end
  end
end
