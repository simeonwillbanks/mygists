require 'spec_helper'

describe TagsController do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:action) { 'show' }
  let(:user) { FactoryGirl.create(:user) }
  let(:tag) { FactoryGirl.create(:tag) }
  let(:profile) do
    user.profile.gists << FactoryGirl.create_list(:gist, 3, profile: user.profile)
    user.profile.gists.each do |gist|
      user.profile.tag(gist, with: tag, on: :descriptions)
    end
    user.profile.decorate
  end
  let(:username) { profile.username }
  let(:params) { {:username => username} }
  let(:action) { 'show' }
  let(:params) { {:username => username, :slug => tag.slug} }
  let(:title) { "#{username} tags: ##{tag}" }

  describe "GET 'show'" do
    it_behaves_like 'a profile'

    context 'authenticated' do
      it 'list items' do
        sign_in user
        get action, params
        profile.gists(tag).each do |li|
          page.should have_content(li.description)
        end
      end

      it 'items are public' do
        sign_in user
        get action, params
        page.should have_selector('i.icon-ok-sign', count: 3)
      end

      it 'and are starred' do
        sign_in user
        get action, params
        page.should have_selector('i.icon-star', count: 3)
      end
    end
  end
end
