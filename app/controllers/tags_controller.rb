class TagsController < ApplicationController
  before_filter :authenticate_user!

  load_and_authorize_resource :profile, singleton: true,
                                        find_by: :username,
                                        id_param: :username

  load_resource :tag, class: ActsAsTaggableOn::Tag

  expose(:profile) { @profile.decorate }
  expose(:current_tag) { @tag.decorate }
  expose(:gists) { profile.gists(@tag) }

  def show
  end
end
