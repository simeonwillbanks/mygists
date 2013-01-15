require "spec_helper"

describe Profile do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:user) }
  it { should belong_to(:user) }
  it { should have_many(:gists) }

  context "custom param key" do
    subject(:profile) { FactoryGirl.build_stubbed(:profile) }
    it { profile.to_param.should eq("simeonwillbanks") }
  end

  context "decrypted token" do
    let(:token) { MyGists::Secure.encrypt("token") }
    subject(:profile) { FactoryGirl.build_stubbed(:profile, token: token) }
    it { profile.token.should eq("token") }
  end

  context "scopes" do
    describe ".usernames" do
      let!(:usernames) do
        FactoryGirl.create_list(:user, 2).inject([]) do |result, user|
          result << user.profile.username
        end
      end
      subject(:scope) { Profile.usernames }

      it "gets usernames" do
        expect(scope).to match_array(usernames)
      end
    end
  end
end
