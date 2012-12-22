require 'spec_helper'

feature 'testing oauth' do
  scenario 'should signin with GitHub' do
    visit root_path
    click_on 'Signin with GitHub'
    page.should have_content('Successfully authenticated from GitHub account.')
    page.should have_content('simeonwillbanks tags')
  end
end
