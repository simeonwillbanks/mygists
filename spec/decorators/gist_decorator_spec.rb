require "spec_helper"

describe GistDecorator do
  subject(:decorator) { FactoryGirl.build(:gist, options).decorate }

  let(:lock_icon) { "<i class=\"icon-lock\"></i>" }
  let(:star_icon) { "<i class=\"icon-star\"></i>" }

  describe "#icons" do
    context "gist is starred" do
      let(:options) { { starred: true } }
      it { decorator.icons.should eq("#{star_icon}") }
    end

    context "gist is starred and private" do
      let(:options) { { starred: true, public: false } }
      it { decorator.icons.should eq("#{star_icon}#{lock_icon}") }
    end

    context "gist is not starred and public" do
      let(:options) { { starred: false, public: true } }
      it { decorator.icons.should be_empty }
    end

    context "gist is not starred and private" do
      let(:options) { { starred: false, public: false } }
      it { decorator.icons.should eq("#{lock_icon}") }
    end
  end

  context "#edit, #url, and #title" do
    let(:gid) { "68c29f86f75b343953ef" }
    let(:username) { "simeonwillbanks" }
    let(:profile) { FactoryGirl.build(:profile, username: username) }

    describe "#edit" do
      let(:options) { { gid: gid, profile: profile} }
      it { decorator.edit.should eq("<a href=\"https://gist.github.com/simeonwillbanks/68c29f86f75b343953ef/edit\" target=\"_blank\"><i class=\"icon-pencil\"></i></a>") }
    end

    describe "#url" do
      let(:options) { { gid: gid, profile: profile} }
      it { decorator.url.should eq("https://gist.github.com/#{username}/#{gid}") }
    end

    describe "#title" do
      context "gist has a title" do
        let(:title) { "settings.yml" }
        let(:options) { { gid: gid, title: title } }
        let(:html) do
          "<a href=\"https://gist.github.com/#{username}/#{gid}\" target=\"_blank\">" \
          "#{title}" \
          "</a>"
        end

        it { decorator.title.should eq(html) }
      end

      context "gist does not have a title" do
        let(:title) { "gistfile1.txt" }
        let(:options) { { gid: gid, title: title } }
        let(:html) do
          "<a href=\"https://gist.github.com/#{username}/#{gid}\" target=\"_blank\">" \
          "gist:#{decorator.source.gid}" \
          "</a>"
        end

        it { decorator.title.should eq(html) }
      end
    end
  end

  describe "#description" do
    context "gist has a description without a tag" do
      let(:description) { "Look at this gist" }
      let(:html) { "<p>#{description}</p>" }
      let(:options) { { description: description } }
      it { decorator.description.should eq(html) }
    end

    context "gist has a description with a tag that has a slug" do
      let(:description) { "Look at this gist #tag" }
      let(:description_with_html) { "Look at this gist <a href=\"/tags/tag\"><span class=\"tag\">#tag</span></a>" }
      let(:html) { "<p>#{description_with_html}</p>" }
      let(:options) { { description: description } }

      it "the description contains a link to the tag" do
        decorator.stub(:linkify_tags).and_return(description_with_html)
        decorator.description.should eq(html)
      end
    end

    context "gist has a description with a tag that does not a slug" do
      let(:description) { "Look at this gist with a #IHaveNoSlug" }
      let(:options) { { description: description } }
      let(:html) { "<p>#{description}</p>" }

      it "the description contains a link to the tag" do
        decorator.stub(:h).and_return(double(content_tag: html, hashtag_to_slug: nil))
        decorator.description.should eq(html)
      end
    end

    context "gist has no description" do
      let(:options) { { description: nil } }
      it { decorator.description.should eq(nil) }
    end
  end
end
