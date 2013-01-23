require 'spec_helper'

describe SearchController do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }

  describe "GET 'index'" do

    context "authenticated" do

      include_context "search test data"

      it "renders search form" do
        sign_in user
        get :index
        page.should have_field("tag")
        page.should have_field("profile")
      end

      it "has search navigation item selected" do
        sign_in user
        get :index
        page.should have_css(".nav li.active a", text: "Search", count: 1)
      end

      it "finds public and not private gists by profile" do
        sign_in user
        get :index, profile: profile.username
        page.should have_content(public_gist.description)
        page.should_not have_content(private_gist.description)
      end

      it "finds public and not private gists by tag" do
        sign_in user
        get :index, tag: public_tag_name
        page.should have_content(public_gist.description)
        page.should have_css("span.text-success", text: public_tag_decorated.name,
                                                  count: 2)
        page.should_not have_content(private_gist.description)
      end

      it "finds public and not private gists by tag and profile" do
        sign_in user
        get :index, tag: generic_tag_name, profile: profile.username
        page.should have_css("span.text-success", text: generic_tag_decorated.name,
                                                  count: 2)
        page.should have_content(generic_public_gist.description)
        page.should_not have_content(private_gist.description)
      end
    end

    context "unauthenticated" do

      include_context "search test data"

      it "should be a success" do
        get :index
        response.should be_success
      end
    end
  end
end
