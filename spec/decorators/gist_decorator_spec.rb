require "spec_helper"

describe GistDecorator do
  subject(:decorator) { FactoryGirl.build(:gist, options).decorate }

  describe "#icons" do
    context "gist is starred and public" do
      let(:options) { { starred: true, public: true } }
      it { decorator.icons.should eq('<i class="icon-star"></i><i class="icon-ok-sign"></i>') }
    end

    context "gist is starred and private" do
      let(:options) { { starred: true, public: false } }
      it { decorator.icons.should eq('<i class="icon-star"></i><i class="icon-lock"></i>') }
    end

    context "gist is not starred and public" do
      let(:options) { { starred: false, public: true } }
      it { decorator.icons.should eq('<i class="icon-ok-sign"></i>') }
    end

    context "gist is not starred and private" do
      let(:options) { { starred: false, public: false } }
      it { decorator.icons.should eq('<i class="icon-lock"></i>') }
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

    context "gist has a description with a tag" do
      let(:description) { "Look at this gist #tag" }
      let(:description_with_html) { "Look at this gist <span class=\"text-success\">#tag</span>" }
      let(:options) { { description: description } }
      it { decorator.description.should eq(description_with_html) }
    end

    context "gist has no description" do
      let(:options) { { description: nil } }
      it { decorator.description.should eq(GistDecorator::DEFAULT_DESCRIPTION) }
    end
  end
end
