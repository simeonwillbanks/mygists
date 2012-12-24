class ProfileController < ApplicationController
  before_filter :authenticate_user!

  load_and_authorize_resource singleton: true,
                              find_by: :username,
                              id_param: :username

  expose(:profile) { @profile.decorate }

  def show
  end
end
