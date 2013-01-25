# Public: A simple data container to house static GitHub urls.
#
# Examples
#
#   GitHub.home_page
#   # => "https://github.com"
#
#   GitHub.gist_page
#   # => "https://gist.github.com"
class GitHub

  # Public: String of GitHub home page url.
  HOME_PAGE     = "https://github.com"

  # Public: String of Gist page url.
  GIST_PAGE     = "https://gist.github.com"

  # Public: String of Simeon Willbanks' GitHub profile url.
  SIMEON_PAGE   = "https://github.com/simeonwillbanks"

  # Public: String of My Gists application repository url.
  MY_GISTS_PAGE = "https://github.com/simeonwillbanks/mygists"

  # Public: String of GitHub API page url.
  API           = "http://developer.github.com"

  # Public: Reader for GitHub home page url.
  #
  # Examples
  #
  #   GitHub.home_page
  #   # => "https://github.com"
  #
  # Returns a String of GitHub home page url.
  def self.home_page
    HOME_PAGE
  end

  # Public: Reader for Gist page url.
  #
  # Examples
  #
  #   GitHub.gist_page
  #   # => "https://gist.github.com"
  #
  # Returns a String of Gist page url.
  def self.gist_page
    GIST_PAGE
  end

  # Public: Reader for Simeon Willbanks' GitHub profile url.
  #
  # Examples
  #
  #   GitHub.simeon_page
  #   # => "https://github.com/simeonwillbanks"
  #
  # Returns a String of Simeon Willbanks' GitHub profile url.
  def self.simeon_page
    SIMEON_PAGE
  end

  # Public: Reader for My Gists application repository url.
  #
  # Examples
  #
  #   GitHub.my_gists_page
  #   # => "https://github.com/simeonwillbanks/mygists"
  #
  # Returns a String of My Gists application repository url.
  def self.my_gists_page
    MY_GISTS_PAGE
  end

  # Public: Reader for GitHub API page url.
  #
  # Examples
  #
  #   GitHub.api
  #   # => "http://developer.github.com"
  #
  # Returns a String of GitHub API page url.
  def self.api
    API
  end

  # Public: Get any users profile page by their username.
  #
  # Examples
  #
  #   GitHub.profile_page("simeonwillbanks")
  #   # => "https://github.com/simeonwillbanks
  #
  def self.profile_page(username)
    "#{HOME_PAGE}/#{username}"
  end
end
