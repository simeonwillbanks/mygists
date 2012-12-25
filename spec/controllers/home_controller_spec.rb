require 'spec_helper'

describe HomeController do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:action) { 'index' }

  describe "get 'index'" do
    context 'unauthenticated' do
      it 'returns http success' do
        get action
        response.should be_success
      end

      it 'has site name' do
        get action
        page.find('h2').should have_content('My Gists')
      end

      it 'call to action' do
        get action
        page.find('h1').should have_content('Organize Your Gists!')
      end

      it 'GitHub signin button' do
        get action
        page.find('.jumbotron > a').should have_content('Sign in with GitHub')
      end

      it_behaves_like 'help'
    end

    context 'authenticated' do
      let(:user) { FactoryGirl.create(:user) }

      it 'redirects to profile' do
        sign_in user
        get action
        response.should redirect_to(profile_path(user.profile))
      end
    end
  end
end
