require 'spec_helper'

describe ProfileController do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:username) { 'simeonwillbanks' }

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', username: username
      response.should be_success
    end

    it "has username" do
      get 'show', username: username
      page.should have_content('simeonwillbanks gists\' tags')
    end

    it "gravatar" do
      get 'show', username: username
      page.should have_selector('img#gravatar', count: 1)
    end

    it "profile menu item" do
      get 'show', username: username
      page.should have_selector('.nav', text: 'Profile', visible: true, count: 1)
    end

    it "how to link" do
      get 'show', username: username
      page.should have_selector('a#how-to', text: 'How do I tag?')
    end

    it "how to text" do
      get 'show', username: username
      page.should_not have_selector('.example', text: 'Include a tag in each gist title.', visible: false)
    end

    ['Rails Templates', 'Terminal Output', 'Diff'].each do |tag|
      it "#{tag} tag" do
        get 'show', username: username
        page.should have_content(tag)
      end
    end
  end
end
