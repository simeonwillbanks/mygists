class TagsController < ApplicationController
  before_filter :authenticate_user!

  load_and_authorize_resource :profile, singleton: true,
                                        find_by: :username,
                                        id_param: :username

  load_resource :tag, class: ActsAsTaggableOn::Tag,
                      find_by: :slug,
                      id_param: :slug

  expose(:profile) { @profile.decorate }
  expose(:current_tag) { @tag.decorate }
  expose(:gists) { profile.gists_for(@tag) }

  before_filter :refresh_gists, only: :index

  def index
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def show
  end

  protected
  # Internal: Refreshes gists for the signed in user's profile.
  #
  # Returns nothing.
  def refresh_gists
    MyGists::Refresh.for(profile)
  end
end
