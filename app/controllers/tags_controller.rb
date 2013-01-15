class TagsController < ApplicationController
  before_filter :authenticate_user!

  load_resource :profile, singleton: true,
                          find_by: :username,
                          id_param: :username

  load_resource :tag, class: ActsAsTaggableOn::Tag,
                      find_by: :slug,
                      id_param: :slug

  expose(:profile) { @profile.decorate }
  expose(:current_tag) { @tag.decorate }

  expose(:gists) do
    MyGists::Search.for :gists, profile: @profile,
                                tag: @tag,
                                private: can?(:read_private_gists, @profile),
                                page: params[:page]
  end

  expose(:tags) do
    MyGists::Search.for :tags, profile: @profile,
                               private: can?(:read_private_tags, @profile)
  end

  before_filter :refresh_gists, only: :index

  def index
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def show
    respond_to { |format| format.html }
  end

  protected
  # Internal: Refreshes gists for the signed in user's profile, if the signed
  #           in user owns the profile. If the signed in user is visiting
  #           another user's profile, do not refresh the gists.
  #
  # Returns nothing.
  def refresh_gists
    MyGists::Refresh.for(profile) if can?(:refresh_gists, @profile)
  end
end
