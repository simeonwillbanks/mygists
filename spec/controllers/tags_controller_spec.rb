require 'spec_helper'

describe TagsController do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { user.profile.decorate }
  let(:public_state) { true }
  let(:tag) { FactoryGirl.create(:tag) }
  let(:tags_cache) do
    {
      MyGists::Cache::Tags.key(tag.name) => { name: tag.name,
                                              slug: tag.slug,
                                              public: public_state }
    }
  end

  before(:each) do
    FactoryGirl.create(:gist, tags: [tag.name],
                              public: public_state,
                              profile: user.profile)
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

    before(:each) do
      MyGists::Cache.should_receive(:read).once.with(:tags).and_return(tags_cache)

      get :show, slug: tag.slug
    end

    it "has tag" do
      page.should have_content(tag.name)
    end

    it "tags menu item" do
      page.should have_css(".nav .active a", text: "Tags", count: 1)
    end

    it "has gist title" do
      page.should have_content(profile.source.gists.first.title)
    end

    it "and description" do
      page.should have_content(profile.source.gists.first.description)
    end
  end
end
