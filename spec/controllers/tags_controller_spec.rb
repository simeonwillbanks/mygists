require 'spec_helper'

describe TagsController do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:action) { 'show' }
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { user.profile.decorate }
  let(:username) { profile.username }
  let(:params) { {:username => username} }
  let(:title) { "#{username} tags" }
  let(:tag) { FactoryGirl.create(:tag) }
  let(:action) { 'show' }
  let(:params) { {:username => username, :id => tag.id} }
  let(:title) { "#{username} tags: #{tag}" }

  describe "GET 'show'" do
    it_behaves_like 'a profile'

    context 'authenticated' do
      it 'list items' do
        sign_in user
        get action, params
        profile.gists.each do |li|
          page.should have_content(li.title)
        end
      end
    end
  end
end
