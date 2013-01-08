require "spec_helper"

describe Gist do
  it { should validate_presence_of(:gid) }
  it { should belong_to(:profile) }
  its(:starred?) { should be_false }

  context "starred" do
    subject { FactoryGirl.build(:gist, starred: true) }
    its(:starred?) { should be_true }
  end

  context "public" do
    subject { FactoryGirl.build(:gist, public: true) }
    its(:public?) { should be_true }
  end

  context "private" do
    subject { FactoryGirl.build(:gist, public: false) }
    its(:public?) { should be_false }
  end

  context "scopes" do
    let(:profile) { FactoryGirl.create(:user).profile }

    describe ".last_touched" do
      let!(:last_touched) { FactoryGirl.create_list(:gist, 2, profile: profile).last }
      subject { Gist.last_touched }

      it "gets last updated gist" do
        expect(subject).to match_array([last_touched])
      end
    end

    describe ".public_null_for" do
      let!(:public_null_for) { FactoryGirl.create(:gist, public: nil, profile: profile) }
      subject { Gist.public_null_for(profile.id) }

      it "by profile id, get gists where public IS NULL" do
        expect(subject).to eq(public_null_for)
      end
    end

    describe ".last_touched_for" do
      let!(:last_touched_for) { FactoryGirl.create(:gist, profile: profile) }
      subject { Gist.last_touched_for(profile.id) }

      it "by profile id, get updated gist" do
        expect(subject).to eq(last_touched_for)
      end
    end

    describe ".find_page_by_tag_name_and_profile" do
      let(:tag) { GithubApiTestHelpers.tag }
      let!(:gist) { FactoryGirl.create(:gist, profile: profile) }

      context "first page" do
        subject { Gist.find_page_by_tag_name_and_profile(1, tag, profile) }

        it "should find the correct page" do
          profile.tag(gist, with: tag, on: :descriptions)
          expect(subject).to match_array([gist])
        end
      end

      context "second page" do
        subject { Gist.find_page_by_tag_name_and_profile(2, tag, profile) }

        it "should find the correct page" do
          expect(subject).to be_empty
        end
      end
    end
  end
end
