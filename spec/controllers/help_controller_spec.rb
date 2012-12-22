require 'spec_helper'

describe HelpController do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:action) { 'index' }

  describe "GET 'index'" do
    it 'returns http success' do
      get action
      response.should be_success
    end

    it_behaves_like 'help'
  end

end
