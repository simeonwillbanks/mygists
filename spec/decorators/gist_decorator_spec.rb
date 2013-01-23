require "spec_helper"

describe GistDecorator do
  subject(:decorator) { FactoryGirl.build(:gist, options).decorate }

  let(:github_icon) do
    "<a href=\"https://gist.github.com/#{decorator.gid}\" target=\"_blank\">" \
    "<i class=\"icon-github\"></i></a>"
  end

  let(:lock_icon) { "<i class=\"icon-lock\"></i>" }
  let(:star_icon) { "<i class=\"icon-star\"></i>" }
  let(:ok_icon) { "<i class=\"icon-ok-sign\"></i>" }

  describe "#icons" do
    context "gist is starred and public" do
      let(:options) { { starred: true, public: true } }
      it { decorator.icons.should eq("#{star_icon}#{ok_icon}#{github_icon}") }
    end

    context "gist is starred and private" do
      let(:options) { { starred: true, public: false } }
      it { decorator.icons.should eq("#{star_icon}#{lock_icon}#{github_icon}") }
    end

    context "gist is not starred and public" do
      let(:options) { { starred: false, public: true } }
      it { decorator.icons.should eq("#{ok_icon}#{github_icon}") }
    end

    context "gist is not starred and private" do
      let(:options) { { starred: false, public: false } }
      it { decorator.icons.should eq("#{lock_icon}#{github_icon}") }
    end
  end

  describe "#url" do
    let(:gid) { "68c29f86f75b343953ef" }
    let(:options) { { gid: gid } }
    it { decorator.url.should eq("https://gist.github.com/#{gid}") }
  end

  describe "#description" do
    context "gist has a description without a tag" do
      let(:description) { "Look at this gist" }
      let(:options) { { description: description } }
      it { decorator.description.should eq(description) }
    end

    context "gist has a description with a tag that has a slug" do
      let(:description) { "Look at this gist #tag" }
      let(:description_with_html) { "Look at this gist <a href=\"/tags/tag\"><span class=\"text-success\">#tag</span></a>" }
      let(:options) { { description: description } }

      it "the description contains a link to the tag" do
        decorator.stub(:linkify_tags).and_return(description_with_html)
        decorator.description.should eq(description_with_html)
      end
    end

    context "gist has a description with a tag that does not a slug" do
      let(:description) { "Look at this gist with a #IHaveNoSlug" }
      let(:options) { { description: description } }

      it "the description contains a link to the tag" do
        decorator.stub(:h).and_return(double(hashtag_to_slug: nil))
        decorator.description.should eq(description)
      end
    end

    context "gist has no description" do
      let(:options) { { description: nil } }
      it { decorator.description.should eq(GistDecorator::DEFAULT_DESCRIPTION) }
    end
  end
end
