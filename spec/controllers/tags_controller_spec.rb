require 'spec_helper'

describe TagsController do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:tag) { 'testing' }
  let(:username) { 'simeonwillbanks' }
  let(:action) { 'show' }
  let(:params) { {:username => username, :id => 1} }
  let(:title) { "#{username} tags: #{tag}" }
  let(:list_items) { ['Gist Title 1', 'Gist Title 2', 'Gist Title 3'] }

  describe "GET 'show'" do
    it_behaves_like 'a profile'
  end
end
