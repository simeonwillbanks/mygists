require "spec_helper"

feature "Profile fetches gists" do
  before(:each) do
    Profile::TagsController.any_instance.stub(:refresh_gists).and_return(true)
  end

  context "success" do
    scenario "should fetch gists from GitHub", js: true do
      visit root_path
      click_on "Sign in with GitHub"
      page.should have_content("Your gists have been fetched from GitHub!")
    end
  end

  context "failure" do
    scenario "should alert user of failure", js: true do
      Profile::TagsController.any_instance.stub(:index).and_raise(Exception)
      visit root_path
      click_on "Sign in with GitHub"
      page.should have_content("An error has occurred, and an administrator notified.")
    end
  end
end
