module ProfileHelper

  # Public: By default, all requests are not considered a profile. However,
  #         the ProfileHelper is mixed into profile requests, so we override
  #         the method definition in ApplicationHelper.
  #
  # Returns a TrueClass.
  def profile?
    true
  end

  # Public: Builds HTML title tag text from the profile username.
  #
  # Examples
  #
  #   page_title
  #   # => "simeonwillbanks | My Gists"
  #
  # Returns a String of the page title.
  def page_title
    super(profile.username)
  end
end
