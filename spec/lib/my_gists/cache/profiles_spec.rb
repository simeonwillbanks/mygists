require "spec_helper"

describe MyGists::Cache::Profiles do

  describe ".data" do
    let(:usernames) { ["simeonwillbanks"] }

    it "gets all profile usernames" do
      Profile.should_receive(:usernames).and_return(usernames)

      described_class.data.should eq(usernames)
    end
  end
end
