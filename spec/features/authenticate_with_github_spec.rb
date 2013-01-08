require "spec_helper"

feature "Authenticate with GitHub via OAuth" do
  scenario "should sign in with GitHub" do
    visit root_path
    click_on "Sign in with GitHub"
    page.should have_content("Successfully authenticated from GitHub account.")
    page.should have_content("simeonwillbanks tags")
  end

  scenario "should sign out" do
    visit root_path
    click_on "Sign in with GitHub"
    visit help_path
    click_on "Sign Out"
    page.should have_content("Signed out successfully.")
    page.should have_content("Sign in with GitHub")
  end
end
