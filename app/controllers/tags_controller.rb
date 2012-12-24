class TagsController < ApplicationController
  before_filter :authenticate_user!

  load_and_authorize_resource :profile, singleton: true,
                                        find_by: :username,
                                        id_param: :username

  expose(:profile) { @profile.decorate }
  expose(:current_tag, model: ActsAsTaggableOn::Tag)
  expose(:gists) { profile.gists.page(params[:page]).collect! {|g| g.decorate} }

  def show
  end
end
