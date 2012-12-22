class ProfileController < ApplicationController
  before_filter :authenticate_user!

  def show
  end
end
