class HomeController < ApplicationController
  before_filter :redirect_signed_in_user

  def index
    respond_to { |format| format.html }
  end

  protected
  # Internal: Home page is for signed out users. When a user is signed in,
  #           redirect the user to their profile page.
  #
  # Returns nothing.
  def redirect_signed_in_user
    redirect_to profile_path(current_user.profile) if user_signed_in?
  end
end
