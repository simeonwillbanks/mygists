require "spec_helper"

describe MyGists::Cache::Tags do

  describe ".data" do

    before(:each) do
      profile = FactoryGirl.create(:user).profile
      FactoryGirl.create(:gist, :public, tags: ["Rails"], profile: profile)
      FactoryGirl.create(:gist, :private, tags: ["Secret"], profile: profile)
    end

    subject(:data) { described_class.data }

    it { data["rails"][:name].should eq("Rails") }
    it { data["rails"][:slug].should eq("rails") }
    it { data["rails"][:public].should be_true }

    it { data["secret"][:name].should eq("Secret") }
    it { data["secret"][:slug].should eq("secret") }
    it { data["secret"][:public].should be_false }
  end
end
