require 'spec_helper'

describe HelpController do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:action) { 'index' }
  let(:user) { FactoryGirl.create(:user) }

  describe "GET 'index'" do
    before(:each) { sign_in user }

    it 'returns http success' do
      get action
      response.should be_success
    end

    it_behaves_like 'help'
  end
end
