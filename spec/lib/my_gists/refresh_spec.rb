require "spec_helper"

describe MyGists::Refresh do
  context "only receives messages via class method" do
    it "sending a message to .new raises an exception" do
      expect { described_class.new }.to raise_exception(NoMethodError)
    end

    it "a message can be sent to .for" do
      described_class.should respond_to(:for)
    end
  end

  describe ".for" do
    let(:tag) { GithubApiTestHelpers.tag }
    let(:profile) { FactoryGirl.create(:user).profile }
    let!(:gists) { GithubApiTestHelpers.gists }

    context "profile has no gists" do
      before(:each) do
        described_class.any_instance.stub(:gists).and_return(gists)
      end

      it "creates a gist for profile" do
        expect { described_class.for(profile) }.to change(Gist, :count).by(1)
      end

      it "tags the profile from gist description" do
        described_class.for(profile)
        profile.owned_tags.length.should eq(1)
        profile.owned_tags.only_public.length.should eq(1)
        profile.owned_tags.first.name.should eq(tag)
      end
    end

    context "profile has gists" do
      let!(:gist) { gists.first }
      before(:each) do
        FactoryGirl.create(:gist, profile: profile, gid: gist["id"])
        described_class.any_instance.stub(:gists).and_return(gists)
      end

      it "updates the gist" do
        expect { described_class.for(profile) }.to change(Gist, :count).by(0)
      end

      it "profile tags stay the same" do
        described_class.for(profile)
        profile.owned_tags.length.should eq(1)
        profile.owned_tags.only_public.length.should eq(1)
        profile.owned_tags.first.name.should eq(tag)
      end
    end
  end
end
