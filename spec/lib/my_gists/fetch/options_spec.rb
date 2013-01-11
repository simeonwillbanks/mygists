require "spec_helper"

describe MyGists::Fetch::Options do

  describe ".to_hash" do
    let(:timestamp) { GithubApiTestHelpers.timestamp }
    let(:gist) { FactoryGirl.build_stubbed(:gist, updated_at: timestamp) }
    let(:profile) { FactoryGirl.build_stubbed(:profile) }

    context "profile gists can be filtered by timestamp" do
      let(:options) do
        {
          username: profile.username,
          token: profile.token,
          since: timestamp
        }
      end

      it "returns a hash with a timestamp" do
        Gist.should_receive(:last_touched_for).with(profile.id).and_return(gist)
        described_class.hash(profile).should eq(options)
      end
    end

    context "profile gists can not be filtered by timestamp" do
      let(:options) do
        {
          username: profile.username,
          token: profile.token,
          since: nil
        }
      end

      it "returns a hash without a timestamp" do
        Gist.should_receive(:last_touched_for).with(profile.id).and_return(nil)
        described_class.hash(profile).should eq(options)
      end
    end
  end
end
