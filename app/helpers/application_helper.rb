# Public: Rails ApplicationHelper. Including all helpers has been turned off
#         in config/application.rb. During a request, the current controller
#         helper and application helper are included, and no other controller
#         helpers are included. Since the application helper is a parent of
#         the current controller helper, the current controller helper can
#         overload application helper methods or use inhertiance and send
#         super.
module ApplicationHelper

  # Public: A hash of navigation items for the main navigation partial. The
  #         keys are the anchor text, and the values are the anchor href.
  #         A current controller helper can overload .navigation_items to
  #         build a specific set of navigation items for that controller's
  #         views.
  #
  # Returns a Hash of navigation items.
  def navigation_items
    {
      profile:  profile_path(current_user.profile),
      help:     help_path,
      sign_out: destroy_user_session_path
    }
  end

  # Public: Builds HTML title tag text from an array of pages. Current
  #         controller helper can define .page_title and call super to build
  #         full page title.
  #
  # pages - The Array of pages which define the path to the current page.
  #         The pages array is built with the splat operator (optional).
  #
  # Examples
  #
  #   page_title
  #   # => "My Gists"
  #
  #   page_title("Profile")
  #   # => "Profile | My Gists"
  #
  #   page_title("simeonwillbanks", "Profile")
  #   # => "simeonwillbanks | Profile | My Gists"
  #
  # Returns a String of the page title.
  def page_title(*pages)
    (pages + ["My Gists"]).join(" | ")
  end

  # Public: When a user signs in with GitHub, we need to alert the user that
  #         their gists are being fetched from GitHub. This predicate tells
  #         the view when the request was redirected from the OmniAuth
  #         callback, and the view should render the gist fetching alert.
  #
  # Examples
  #
  #   render_fetching_info?
  #   # => true
  #
  #   render_fetching_info?
  #   # => false
  #
  # Returns a TrueClass or FalseClass.
  def render_fetching_info?
    flash[:from_omniauth_callback] == true
  end

  # Public: Exposes an interface to GitHub model.
  #
  # Examples
  #
  #   github.home_page
  #   # => "https://github.com"
  #
  #   github.gist_page
  #   # => "https://gist.github.com"
  #
  # Returns GitHub model.
  def github
    GitHub
  end
end
