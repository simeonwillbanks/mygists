module ProfileHelper

  # Public: Builds HTML title tag text from the profile username.
  #
  # Examples
  #
  #   page_title
  #   # => "simeonwillbanks | My Gists"
  #
  # Returns a String of the page title.
  def page_title
    super(current_user.profile.username)
  end
end
