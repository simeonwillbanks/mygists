module MyGists

  # Public: Fetches gists from GitHub for a profile.
  #
  # Examples
  #
  #   MyGists::Fetch.for(username: "foo", token: "7bfdda")
  #
  #   MyGists::Fetch.for(username: "foo",
  #                      token: "7bfdda",
  #                      since: "2013-01-09T18:04:56Z")
  class Fetch

    class << self
      # Internal: Only Fetch.for can initialize a new Fetch.
      protected :new
    end

    # Public: Fetches gists from GitHub for a profile.
    #
    # options  - The Hash containing key/value pairs used to fetch gists.
    #            :username - The String username used to find GitHub user.
    #            :token    - The String OAuth2 Token used to authenticate the
    #                        user.
    #            :since    - A String timestamp in ISO 8601 format:
    #                        YYYY-MM-DDTHH:MM:SSZ. Only gists updated at or
    #                        after this time are fetched (optional).
    #
    # Examples
    #
    #   MyGists::Fetch.for(username: "foo", token: "7bfdda")
    #
    #   MyGists::Fetch.for(username: "foo",
    #                      token: "7bfdda",
    #                      since: "2013-01-09T18:04:13Z")
    #   # => [{ "id"          => "1"
    #           "description" => "A gist with a #tag",
    #           "public"      => true,
    #           "updated_at"  => "2013-01-10T17:03:56Z",
    #           "created_at"  => "2013-01-08T16:11:46Z",
    #           "starred"     => true }]
    #
    # Returns an Array of Hashes. Each Hash is a fetched gist.
    def self.for(options)
      new(options) do
        login

        return gists
      end
    end

    # Public: Initialize a Fetch.
    #
    # options  - The Hash containing key/value pairs used to fetch gists.
    #            :username - The String username used to find GitHub user.
    #            :token    - The String OAuth2 Token used to authenticate the
    #                        user.
    #            :since    - A String timestamp in ISO 8601 format:
    #                        YYYY-MM-DDTHH:MM:SSZ. Only gists updated at or
    #                        after this time are fetched (optional).
    #
    # Yields within context of self.
    def initialize(options, &block)
      @username = options.delete(:username)
      @token = options.delete(:token)
      @options = options
      instance_eval(&block) if block_given?
    end

    private
    # Internal: Returns the String username of the received options.
    attr_reader :username

    # Internal: Returns the String token of the received options.
    attr_reader :token

    # Internal: Returns the Hash of the received options.
    attr_reader :options

    # Internal: Returns the Ockokit::Client instance.
    attr_reader :client

    # Internal: Connect to GitHub API via username and token attributes, and
    #           set client attribute.
    #
    # Examples
    #
    #   login
    #   # => #<Ockokit::Client:0x007fbb38166750>
    #
    # Returns an Ockokit::Client instance.
    def login
      @client = Octokit::Client.new(login: username, oauth_token: token)
    end

    # Internal: Via the client attribute, fetch gists by the username and
    #           and options attributes. Once the gists have fetched, get and
    #           set the gists star status.
    # Examples
    #
    #   gists
    #   # => [{ "id"          => "1"
    #           "description" => "A gist with a #tag",
    #           "public"      => true,
    #           "updated_at"  => "2013-01-10T17:03:56Z",
    #           "created_at"  => "2013-01-08T16:11:46Z",
    #           "starred"     => true }]
    #
    # Returns an Array of Hashes. Each Hash is a fetched gist.
    def gists
      client.gists(username, options).collect do |gist|
        gist["starred"] = client.gist_starred?(gist["id"])
        gist
      end
    end
  end
end
