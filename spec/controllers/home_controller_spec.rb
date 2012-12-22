require 'spec_helper'

describe HomeController do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:action) { 'index' }

  describe "get action" do
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
        page.find('.jumbotron a').should have_content('Signin with GitHub')
      end

      it_behaves_like 'help'
    end
  end
end
