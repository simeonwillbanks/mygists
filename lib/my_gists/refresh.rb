module MyGists

  # Public: Refreshes gists for a given profile.
  #
  # Examples
  #
  #   MyGists::Refresh.for(profile)
  class Refresh

    class << self
      # Internal: Only Refresh.for can initialize a new Refresh.
      protected :new
    end

    # Public: Refreshes gists for a received profile.
    #
    # profile - The Profile instance whose gists need refreshing.
    #
    # Examples
    #
    #   MyGists::Refresh.for(profile)
    #
    # Returns nothing.
    def self.for(profile)
      new(profile) do
        refresh
      end
    end

    # Public: Initialize a Refresh.
    #
    # profile - The Profile instance whose gists need refreshing.
    #
    # Yields within context of self.
    def initialize(profile, &block)
      @profile = profile
      instance_eval(&block) if block_given?
    end

    private
    # Internal: Returns the recieved Profile instance.
    attr_reader :profile

    # Internal: Returns the Hash of fetched gist.
    attr_reader :fetched_gist

    # Internal: Returns the Gist instance from the fetched gist.
    attr_reader :gist

    # Internal: Using the GitHub API, fetch gists for the profile attribute.
    #           For each fetched gist, save a Gist instance and tag the Gist.
    #
    # Returns nothing.
    def refresh
      gists.each do |fetched_gist|
        @fetched_gist = fetched_gist

        save_gist

        tag_gist

        post_process_gist
      end
    end

    # Internal: Using the GitHub API, fetch gists for the profile attribute.
    #
    # Examples
    #
    #   gists
    #   # => [{ "id"          => "1"
    #           "description" => "A gist with a #tag",
    #           "public"      => true,
    #           "updated_at"  => "2013-01-10T17:03:56Z",
    #           "created_at"  => "2013-01-08T16:11:46Z" }]
    #
    # Returns an Array of Hashes. Each Hash is a fetched gist.
    def gists
      MyGists::Fetch.for(MyGists::Fetch::Options.hash(profile))
    end

    # Internal: For the current fetched gist, get the gist's GitHub ID.
    #
    # Examples
    #
    #   gid
    #   # => "1"
    #
    # Returns a String ID.
    def gid
      fetched_gist["id"]
    end

    # Internal: For the current fetched gist, get the gist's title from it's
    #           files.
    #
    # Examples
    #
    #   title
    #   # => "gistfile1.txt"
    #
    #   title
    #   # => ".pryrc"
    #
    # Returns a String title.
    def title
      fetched_gist["files"].try(:first).try(:first) || Gist.default_title
    end

    # Internal: With the profile and gid attributes, find or create a new Gist
    #           from the current fetched gist. Once the Gist instance is
    #           created set the gist attribute on self.
    #
    # Returns nothing.
    def save_gist
      @gist = Gist.find_or_create_by_profile_id_and_gid(profile.id, gid).tap do |g|
        g.title = title
        g.description = fetched_gist["description"]
        g.created_at = fetched_gist["created_at"]
        g.updated_at = fetched_gist["updated_at"]
        g.public = fetched_gist["public"]
        g.save!
      end
    end

    # Internal: For the current gist attribute, extract tags from the gist's
    #           description. Next, tag the gist with the extracted tags. The
    #           tags are owned by the profile attribute.
    #
    # Returns nothing.
    def tag_gist
      profile.tag(gist, with: MyGists::Tags.for(gist), on: context)
    end

    # Internal: After a gist has been saved, perform any post processing. For
    #           now, the gist is sent to a background job, and its star status
    #           is fetched.
    #
    # Returns nothing.
    def post_process_gist
      Resque.enqueue(MyGists::Jobs::GistStarStatus, gist.id) if gist.starred.nil?
    end

    # Internal: Each tagging has a context. The context can either be public
    #           or private. The context matches the gist state. When a gist is
    #           public, its tags are public, and vice versa.
    #
    #   context
    #   # => "public"
    #
    #   context
    #   # => "private"
    #
    # Returns a String of the tag context.
    def context
      gist.public? ? ActsAsTaggableOn::Tag.context(:public) : ActsAsTaggableOn::Tag.context(:private)
    end
  end
end
