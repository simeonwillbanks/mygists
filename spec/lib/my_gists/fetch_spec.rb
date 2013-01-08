require "spec_helper"

describe MyGists::Fetch do
  context "only receives messages via class method" do
    it "sending a message to .new raises an exception" do
      expect { described_class.new }.to raise_exception(NoMethodError)
    end

    it "a message can be sent to .for" do
      described_class.should respond_to(:for)
    end
  end

  describe ".for" do
    let!(:options) { GithubApiTestHelpers.options }
    let!(:gists) { GithubApiTestHelpers.gists }
    let!(:client) { double(gists: gists, gist_starred?: true) }

    before(:each) do
      Octokit::Client.stub(:new).and_return(client)
    end

    it "returns an array of gists" do
      described_class.for(options).should eq(gists)
    end

    it "fetching gists can be done with optional timestamp" do
      options.merge!(since: GithubApiTestHelpers.timestamp)
      client.should_receive(:gists).with(options[:username], options)
      described_class.for(options).should eq(gists)
    end

    it "fetched gists are updated with star status" do
      client.should_receive(:gist_starred?).once
      described_class.for(options)
    end
  end
end
