class SearchController < ApplicationController

  expose(:tags) { MyGists::Cache.read(:tags) }
  expose(:profiles) { MyGists::Cache.read(:profiles) }

  expose(:gists) { @gists }

  before_filter :search, if: :search_params?

  def index
    respond_to { |format| format.html }
  end

  protected
  # Internal: Predicate for deciding when to search. If search params exist,
  #           a search will be performed.
  #
  # Returns a TrueClass or FalseClass.
  def search_params?
    !params[:tag].nil? || !params[:profile].nil?
  end

  # Internal: Search for public gists by request params, and set gists
  #           instance variable.
  #
  # Returns nothing.
  def search
    @gists = MyGists::Search.for :gists, profile: params[:profile],
                                         tag: params[:tag],
                                         private: false,
                                         page: params[:page]
  end
end
