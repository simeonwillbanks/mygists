require 'spec_helper'

describe ProfileController do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:action) { 'show' }
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { user.profile.decorate }
  let(:username) { profile.username }
  let(:token) { profile.token }
  let(:params) { {:username => username} }
  let(:title) { "#{username} tags" }

  describe "GET 'show'" do
    before(:each) do
      described_class.any_instance.stub(:refresh_gists).and_return(true)
    end

    it_behaves_like 'a profile'

    context 'authenticated' do
      it 'renders fetching notice' do
        sign_in user
        get action, params
        page.should have_content('One moment please, your gists are being fetched from GitHub.')
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
