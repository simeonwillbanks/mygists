module MyGists

  # Internal: A gist is sent to this background job, so its star status
  #           can be fetched from the GitHub API. This pushes the extra HTTP
  #           request into the background.
  #
  # Examples
  #
  #   MyGists::Jobs::GistStarStatus.perform(gist_id)
  class Jobs::GistStarStatus

    # Public: class instance variable which determines where job will be
    #         placed.
    @queue = :gists

    # Public: Required method for Resque job. Send the given gist ID to a star
    #         status fetcher.
    #
    # gist_id - The Integer of a Gist ID.
    #
    # Returns nothing.
    def self.perform(gist_id)
      MyGists::Fetch::StarStatus.for(gist_id)
    end
  end
end
