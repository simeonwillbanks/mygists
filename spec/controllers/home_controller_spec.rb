require 'spec_helper'

describe HomeController do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }

  describe "GET 'index'" do
    context 'unauthenticated' do
      it "returns http success" do
        get 'index'
        response.should be_success
      end

      it "has site name" do
        get 'index'
        page.find('h2').should have_content('My Gists')
      end

      it "call to action" do
        get 'index'
        page.find('h1').should have_content('Organize Your Gists!')
      end

      it "GitHub signin button" do
        get 'index'
        page.find('.jumbotron a').should have_content('Signin with GitHub')
      end

      it "Tagging description" do
        get 'index'
        page.should have_content('Include a tag in each gist title.')
      end
    end
  end
end
