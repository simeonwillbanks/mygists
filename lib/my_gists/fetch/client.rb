module MyGists

  # Public: Mixin for defining a client to the GitHub API.
  module Fetch::Client
    extend ActiveSupport::Concern

    included do

      private
      # Internal: Returns the Ockokit::Client instance.
      attr_reader :client

      # Internal: Returns the String username for client login.
      attr_reader :username

      # Internal: Returns the String token for the client login.
      attr_reader :token

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
    end
  end
end
