module MyGists

  # Public: Fetches a gist's star status from GitHub.
  #
  # Examples
  #
  #   MyGists::Fetch:StarStatus.for(gist_id)
  class Fetch::StarStatus

    class << self
      # Internal: Only Fetch::StarStatus.for can initialize a new
      #           Fetch::StarStatus.
      protected :new
    end

    # Public: From the given gist ID, fetch the gist's star status and update
    #         the gist.
    #
    # gist_id - The Integer of a Gist ID.
    #
    # Examples
    #
    #   MyGists::Fetch::StarStatus.for(gist_id)
    #
    # Returns nothing.
    def self.for(gist_id)
      new(gist_id) do
        login

        fetch_star_status

        update_gist
      end
    end

    # Public: Initialize a Fetch::StarStatus.
    #
    # gist_id - The Integer of a Gist ID.
    #
    # Yields within context of self.
    def initialize(gist_id, &block)
      @gist = Gist.find(gist_id)

      gist.profile.tap do |profile|
        @username = profile.username
        @token = profile.token
      end

      instance_eval(&block) if block_given?
    end

    private
    include MyGists::Fetch::Client

    # Internal: Returns a Gist instance from the received gist ID.
    attr_reader :gist

    # Internal: Returns the star status of the gist attribute.
    attr_reader :star_status

    # Internal: Using the GitHub API, fetch the gist star status for the gist
    #           attribute.
    #
    # Returns nothing.
    def fetch_star_status
      @star_status = client.gist_starred?(gist.gid)
    end

    # Internal: Update the gist attribute's starred boolean to match the
    #           fetched status without invoking validations or callbacks.
    #           Plus, we do not want to touch updated_at, since it should
    #           remain in sync with the fetched gist's updated_at.
    #
    # Returns nothing.
    def update_gist
      gist.update_column(:starred, starred?)
    end

    # Internal: The star status of the gist attribute from the star_status
    #           attribute.
    #
    # Examples
    #
    #   starred?
    #   # => true
    #
    #   starred?
    #   # => false
    #
    # Returns a TrueClass or FalseClass.
    def starred?
      star_status
    end
  end
end
