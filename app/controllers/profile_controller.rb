class ProfileController < ApplicationController

  load_resource singleton: true, find_by: :username, id_param: :username

  expose(:profile) { @profile.decorate }

  def show
    respond_to { |format| format.html }
  end
end
