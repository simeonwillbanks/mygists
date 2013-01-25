require "spec_helper"

describe Gist do
  it { should validate_presence_of(:gid) }
  it { should belong_to(:profile) }

  context "starred" do
    subject(:gist) { FactoryGirl.build(:gist, starred: true) }
    it { gist.starred?.should be_true }
  end

  context "public" do
    subject(:gist) { FactoryGirl.build(:gist, public: true) }
    it { gist.public?.should be_true }
  end

  context "private" do
    subject(:gist) { FactoryGirl.build(:gist, public: false) }
    it { gist.public?.should be_false }
  end

  describe ".default_title" do
    subject(:gist) { Gist }
    it { gist.default_title.should eq("gistfile1.txt") }
  end

  describe ".default_title_regex" do
    subject(:gist) { Gist }
    it { gist.default_title_regex.should eq(/\Agistfile1/) }
  end

  context "scopes" do
    let(:profile) { FactoryGirl.create(:user).profile }

    describe ".last_touched" do
      let!(:last_touched) { FactoryGirl.create_list(:gist, 2, profile: profile).last }
      subject(:gist) { Gist.last_touched }

      it "gets last updated gist" do
        expect(gist).to match_array([last_touched])
      end
    end

    describe ".only_public" do
      let!(:only_public) { FactoryGirl.create(:gist, public: true, profile: profile) }
      subject(:gist) { Gist.only_public(profile.id) }

      it "by profile id, get public gists" do
        expect(gist).to match_array([only_public])
      end
    end

    describe ".last_touched_for" do
      let!(:last_touched_for) { FactoryGirl.create(:gist, profile: profile) }
      subject(:gist) { Gist.last_touched_for(profile.id) }

      it "by profile id, get updated gist" do
        expect(gist).to eq(last_touched_for)
      end
    end
  end
end
