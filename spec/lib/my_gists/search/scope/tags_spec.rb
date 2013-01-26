require "spec_helper"

describe MyGists::Search::Scope::Tags do

  after(:each) { described_class.by(profile: profile, tag_name: tag_name) }

  describe "#by_profile_tag" do
    let(:profile) { FactoryGirl.build_stubbed(:profile) }
    let(:tag_name) { "rails" }

    it "scopes a query by a profile's tag" do
      described_class.any_instance.should_receive(:by_profile_tag).once
    end
  end

  describe "#by_profile" do
    let(:profile) { FactoryGirl.build_stubbed(:profile) }
    let(:tag_name) { nil }

    it "scopes a query by a profile" do
      described_class.any_instance.should_receive(:by_profile).once
    end
  end

  describe "#by_tag" do
    let(:profile) { nil }
    let(:tag_name) { "rails" }

    it "scopes a query by a tag" do
      described_class.any_instance.should_receive(:by_tag).once
    end
  end

  describe "#use_default" do
    let(:profile) { nil }
    let(:tag_name) { nil }

    it "scopes a query by the default" do
      described_class.any_instance.should_receive(:use_default).once
    end
  end
end
