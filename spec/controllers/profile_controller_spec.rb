require 'spec_helper'

describe ProfileController do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:action) { 'show' }
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { user.profile.decorate }
  let(:username) { profile.username }
  let(:params) { {:username => username} }
  let(:title) { "#{username} tags" }

  describe "GET 'show'" do
    it_behaves_like 'a profile'

    context 'authenticated' do
      it 'list items' do
        sign_in user
        list_items = FactoryGirl.create_list(:tag, 3)
        Profile.any_instance.stub(:owned_tags).and_return(list_items)
        get action, params
        list_items.each do |li|
          page.should have_content(li.name)
        end
      end
    end

    context 'viewing another users profile' do
      it 'redirects to correct profile' do
        sign_in user
        another_user = FactoryGirl.create(:user, profile: FactoryGirl.build(:profile, username: 'another'))
        get action, username: another_user.profile.username
        response.should redirect_to profile_path(user.profile)
      end
    end
  end
end
