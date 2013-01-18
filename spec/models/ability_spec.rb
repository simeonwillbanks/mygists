require "spec_helper"

describe Ability do
  subject { ability }
  let(:ability) { Ability.new(user) }
  let(:user) { nil }

  context "guest user views a profile" do
    it { should be_able_to(:read, Profile) }
    it { should be_able_to(:read, ActsAsTaggableOn::Tag) }
    it { should_not be_able_to(:read_private_tags, nil) }
    it { should_not be_able_to(:read_private_gists, nil) }
    it { should_not be_able_to(:refresh_gists, nil) }
  end

  context "user views their profile" do
    let(:user) { FactoryGirl.create(:user) }
    it { should be_able_to(:read_private_tags, user.profile) }
    it { should be_able_to(:read_private_gists, user.profile) }
    it { should be_able_to(:refresh_gists, user.profile) }
  end

  context "user views another users profile" do
    let(:user) { FactoryGirl.create(:user) }
    let(:another_user) { FactoryGirl.create(:user) }
    it { should_not be_able_to(:read_private_tags, another_user.profile) }
    it { should_not be_able_to(:read_private_gists, another_user.profile) }
    it { should_not be_able_to(:refresh_gists, another_user.profile) }
  end
end
