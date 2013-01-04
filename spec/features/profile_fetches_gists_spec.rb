require 'spec_helper'

feature 'Profile fetches gists' do
  before(:each) do
    TagsController.any_instance.stub(:refresh_gists).and_return(true)
  end

  scenario 'should fetch gists from GitHub', js: true do
    visit root_path
    click_on 'Sign in with GitHub'
    page.should have_content('Your gists have been fetched from GitHub!')
  end
end
