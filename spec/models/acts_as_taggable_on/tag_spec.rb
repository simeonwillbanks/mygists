require "spec_helper"

describe ActsAsTaggableOn::Tag do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }

  context "class methods" do
    subject(:klass) { described_class }

    it { klass.default.should eq("Without Tags") }
    it { klass.context(:public).should eq("public") }
    it { klass.context(:private).should eq("private") }
  end

  context "scopes" do
    describe ".by_name" do
      let(:name) { "rails" }
      let!(:by_name) { FactoryGirl.create(:tag, name: name) }
      subject(:tag) { ActsAsTaggableOn::Tag.by_name(name) }

      it "gets tag by name" do
        expect(tag).to match_array([by_name])
      end
    end

    describe ".names" do
      let(:name) { "rails" }
      let!(:by_name) { FactoryGirl.create(:tag, name: name) }
      subject(:tag) { ActsAsTaggableOn::Tag.names }

      it "gets all tag names" do
        expect(tag).to match_array([name])
      end
    end

    describe ".public_names" do
      before(:each) do
        profile = FactoryGirl.create(:user).profile
        FactoryGirl.create(:gist, :public, tags: ["rails"], profile: profile)
        FactoryGirl.create(:gist, :private, tags: ["secret"], profile: profile)
      end
      subject(:scope) { ActsAsTaggableOn::Tag.public_names }

      it "gets names" do
        expect(scope).to match_array(["rails"])
      end
    end

    describe ".public_tags" do
      before(:each) do
        profile = FactoryGirl.create(:user).profile
        FactoryGirl.create(:gist, :public, tags: ["rails"], profile: profile)
        FactoryGirl.create(:gist, :private, tags: ["secret"], profile: profile)
      end
      subject(:scope) { ActsAsTaggableOn::Tag.public_tags }
      let(:rails) { ActsAsTaggableOn::Tag.find_by_name("rails") }

      it "gets tags" do
        expect(scope).to match_array([rails])
      end
    end
  end

  context "instance methods" do
    subject(:tag) { FactoryGirl.create(:tag, name: name) }

    context "default tag" do
      let(:name) { "Without Tags" }
      it { tag.default?.should be_true }
      it { tag.slug.should eq("without-tags") }
    end

    context "tag other than default" do
      let(:name) { "rails" }
      it { tag.default?.should be_false }
      it { tag.slug.should eq("rails") }
    end

    context "tag is not sluggable" do
      let(:name) { '#{}' }
      it { tag.slug.should eq("--") }
    end
  end
end
