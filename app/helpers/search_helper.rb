module SearchHelper

  # Public: Fetches profile from request parameters.
  #
  # Examples
  #
  #   profile_search_term
  #   # => "simeonwillbanks"
  #
  #   profile_search_term
  #   # => nil
  #
  # Returns a String of profile username or NilClass.
  def profile_search_term
    params[:profile]
  end

  # Public: Fetches tag from request parameters.
  #
  # Examples
  #
  #   tag_search_term
  #   # => "rails"
  #
  #   tag_search_term
  #   # => nil
  #
  # Returns a String of profile username or NilClass.
  def tag_search_term
    params[:tag]
  end

  # Public: When a search term exists, a search will be performed.
  #         Otherwise, a search will not be performed.
  #
  # Returns a TrueClass or FalseClass.
  def search?
    !tag_search_term.nil? || !profile_search_term.nil?
  end

  # Public: Checks whether or not a profile search term exists.
  #
  # Returns a TrueClass or FalseClass.
  def profile_search?
    profile_search_term.present?
  end

  # Public: Checks whether or not a tag search term exists.
  #
  # Returns a TrueClass or FalseClass.
  def tag_search?
    tag_search_term.present?
  end

  # Public: Constructs a hashtag from tag search term.
  #
  # Examples
  #
  #   search_hashtag
  #   # => "#rails"
  #
  # Returns a String of hashtag.
  def search_hashtag
    "##{tag_search_term}"
  end

  # Public: Constructs a HTML anchor tag to a profile page from profile search
  #         term.
  #
  # Examples
  #
  #   search_profile_link
  #   # => "<a href=\"/simeonwillbanks\">simeonwillbanks</a>"
  #
  # Returns a String of HTML anchor tag.
  def search_profile_link
    link_to profile_search_term, profile_path(profile_search_term)
  end

  # Public: Builds HTML title tag text for Search pages.
  #
  # Examples
  #
  #   page_title
  #   # => "Search | My Gists"
  #
  # Returns a String of the page title.
  def page_title
    super("Search")
  end
end
