module MyGists

  # Public: Data for profiles cache. A Duck for the MyGists::Cache role.
  #
  # Examples
  #
  #   MyGists::Cache::Profiles.data
  class Cache::Profiles

    # Public: Data for profiles cache which is all Profile usernames.
    #
    # Examples
    #
    #   MyGists::Cache::Profiles.data
    #   # => ["username"]
    #
    # Returns an Array of usernames.
    def self.data
      Profile.usernames
    end
  end
end
