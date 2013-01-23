module Profile::TagsHelper

  # Public: By default, all requests are not considered a profile. However,
  #         the Profile::TagsHelper is mixed into profile requests, so we
  #         override the ApplicationHelper.profile? definition.
  #
  # Returns a TrueClass.
  def profile?
    true
  end

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
