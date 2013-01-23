require "spec_helper"

describe Profile::TagsController do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:action) { "show" }
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { user.profile.decorate }
  let(:username) { profile.username }
  let(:params) { { username: username, slug: tag.slug } }
  let(:title) { "#{username} tags: ##{tag}" }
  let(:public_state) { true }
  let(:tag) { FactoryGirl.create(:tag) }
  let(:tags_cache) do
    {
      MyGists::Cache::Tags.key(tag.name) => { name: tag.name,
                                              slug: tag.slug,
                                              public: public_state }
    }
  end

  describe "GET 'show'" do

    it_behaves_like "a profile"

    context "authenticated" do
      before(:each) do
        FactoryGirl.create_list(:gist, 3, tags: [tag.name],
                                          public: public_state,
                                          profile: user.profile)

        MyGists::Cache.should_receive(:read).at_most(:twice).with(:tags).and_return(tags_cache)

        sign_in user
        get action, params
      end

      it "list items" do
        profile.gists.each do |li|
          page.should have_content(li.description)
        end
      end

      it "items are public" do
        page.should have_selector("i.icon-ok-sign", count: 3)
      end

      it "and are starred" do
        page.should have_selector("i.icon-star", count: 3)
      end

      it "viewing another users gists by tag renders that users gists" do
        page.should have_content(title)

        sign_in FactoryGirl.create(:user, profile: FactoryGirl.build(:profile, username: "another"))
        get action, params

        page.should have_content(title)
      end
    end
  end
end
