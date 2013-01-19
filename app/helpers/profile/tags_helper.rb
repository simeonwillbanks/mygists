module Profile::TagsHelper

  # Public: Builds HTML title tag text from current tag and profile username
  #         for tags views.
  #
  # Examples
  #
  #   page_title
  #   # => "Rails | simeonwillbanks | My Gists"
  #
  # Returns a String of the page title.
  def page_title
    super(current_tag.name, profile.username)
  end
end
