require 'spec_helper'

describe TagsController do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { user.profile.decorate }
  let(:tag) { FactoryGirl.create(:tag) }

  before(:each) do
    profile.gists << FactoryGirl.create(:gist, profile: user.profile)

    profile.gists.each do |gist|
      profile.tag(gist, with: tag, on: "public")
    end
  end

  describe "GET 'index'" do

    before(:each) { get :index }

    it "has tag" do
      page.should have_content(tag.name)
    end

    it "tags menu item" do
      page.should have_css(".nav .active a", text: "Tags", count: 1)
    end
  end

  describe "GET 'show'" do

    before(:each) { get :show, slug: tag.slug }

    it "has tag" do
      page.should have_content(tag.name)
    end

    it "tags menu item" do
      page.should have_css(".nav .active a", text: "Tags", count: 1)
    end

    it "has gist" do
      page.should have_content(profile.gists.first.description)
    end
  end
end
