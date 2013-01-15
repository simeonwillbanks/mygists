require "spec_helper"

describe ProfileController do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:action) { "show" }
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { user.profile.decorate }
  let(:username) { profile.username }
  let(:params) { { username: username } }
  let(:title) { "#{username} tags" }

  describe "GET 'show'" do
    before(:each) do
      described_class.any_instance.stub(:refresh_gists).and_return(true)
    end

    it_behaves_like "a profile"

    context "authenticated" do
      it "renders fetching indicator" do
        sign_in user
        get action, params
        page.should have_selector("div#gists-fetching-spinner img")
      end

      context "viewing another users profile" do
        it "renders that users profile" do
          sign_in user
          another_user = FactoryGirl.create(:user, profile: FactoryGirl.build(:profile, username: "another"))
          get action, username: another_user.profile.username
          page.should have_content(another_user.profile.username)
        end
      end
    end

    context "unauthenticated" do
      it "redirects to home page" do
        get action, params
        response.should redirect_to root_path
      end
    end
  end
end
