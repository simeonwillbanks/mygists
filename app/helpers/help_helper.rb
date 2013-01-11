module HelpHelper

  # Public: Builds HTML title tag text for Help pages.
  #
  # Examples
  #
  #   page_title
  #   # => "Help | My Gists"
  #
  # Returns a String of the page title.
  def page_title
    super("Help")
  end
end
