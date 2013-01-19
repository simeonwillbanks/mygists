module TagsHelper

  # Public: Builds HTML title tag text from current tag and "Tags".
  #
  # Examples
  #
  #   page_title
  #   # => "Tags | My Gists"
  #
  #   page_title
  #   # => "Rails | Tags | My Gists"
  #
  # Returns a String of the page title.
  def page_title
    args = ["Tags"]
    args.prepend(current_tag.name) if current_tag
    super(*args)
  end
end
