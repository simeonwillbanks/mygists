class HomeController < ApplicationController
  before_filter :redirect_signed_in_user

  def index
  end

  protected
  def redirect_signed_in_user
    redirect_to profile_path(current_user.profile) if user_signed_in?
  end
end
