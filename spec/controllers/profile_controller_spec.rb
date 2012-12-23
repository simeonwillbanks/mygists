require 'spec_helper'

describe ProfileController do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:user) { FactoryGirl.create(:user) }
  let(:username) { user.profile.username }
  let(:action) { 'show' }
  let(:params) { {:username => username} }
  let(:title) { "#{username} tags" }
  let(:list_items) { ['Rails Templates', 'Terminal Output', 'Diff'] }

  describe "GET 'show'" do
    it_behaves_like 'a profile'
  end
end
