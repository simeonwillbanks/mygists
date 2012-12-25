class ProfileController < ApplicationController
  before_filter :authenticate_user!

  load_and_authorize_resource singleton: true,
                              find_by: :username,
                              id_param: :username

  expose(:profile) { @profile.decorate }

  before_filter :refresh_gists

  def show
  end

  protected

  def refresh_gists
    MyGists::Refresh.for(profile)
  end
end
