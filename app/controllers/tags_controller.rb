class TagsController < ApplicationController

  load_resource :tag, class: ActsAsTaggableOn::Tag,
                      find_by: :slug,
                      id_param: :slug

  expose(:current_tag) { @tag.decorate if @tag }

  expose(:tags) { MyGists::Public.tags(params[:page]) }

  expose(:gists) do
    MyGists::Search.for :gists, tag: @tag,
                                private: false,
                                page: params[:page]
  end

  def index
    respond_to { |format| format.html }
  end

  def show
    respond_to { |format| format.html }
  end
end
