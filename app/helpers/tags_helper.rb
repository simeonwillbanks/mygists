module TagsHelper

  # Public: Builds HTML title tag text from an array of pages for tags views.
  #
  # Examples
  #
  #   page_title
  #   # => "Rails | simeonwillbanks | My Gists"
  #
  # Returns a String of the page title.
  def page_title
    super([current_tag.name, current_user.profile.username])
  end
end
