module MyGists
  class Fetch

    class << self
      protected :new

      def for(options)
        new(options) do
          login
          return gists
        end
      end
    end

    def initialize(options, &block)
      @username = options.delete(:username)
      @token = options.delete(:token)
      @options = options
      instance_eval(&block) if block_given?
    end

    private

    attr_reader :username, :token, :options, :client

    def login
      @client = Octokit::Client.new(login: username, oauth_token: token)
    end

    def gists
      client.gists(username, options).collect{|g| g['starred'] = client.gist_starred?(g['id']); g }
    end
  end
end
