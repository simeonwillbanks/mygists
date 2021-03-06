# Public: Rails ApplicationHelper. Including all helpers has been turned off
#         in config/application.rb. During a request, the current controller
#         helper and application helper are included, and no other controller
#         helpers are included. Since the application helper is a parent of
#         the current controller helper, the current controller helper can
#         overload application helper methods or use inhertiance and send
#         super.
module ApplicationHelper

  # Public: By default, all requests are not considered a profile. This method
  #         can be overridden by modules like ProfileHelper.
  #
  # Returns a FalseClass.
  def profile?
    false
  end

  # Public: Within the correct context, build a tag path which matches the
  #         given slug.
  #
  # options - The Hash of param options for a specific Tag.
  #
  # Examples
  #
  #   tag_path(slug: "rails")
  #   # => "/tags/rails"
  #
  #   tag_path(slug: "rails")
  #   # => "/simeonwillbanks/tags/rails"
  #
  # Returns a String of the page title.
  def tag_path(options)
    if profile?
      profile_tag_path(profile, options)
    else
      super(options)
    end
  end

  # Public: A hash of navigation items for the main navigation partial. The
  #         keys are the anchor text, and the values are the anchor href.
  #         A current controller helper can overload .navigation_items to
  #         build a specific set of navigation items for that controller's
  #         views.
  #
  # Returns a Hash of navigation items.
  def navigation_items
    if user_signed_in?
      {
        my_profile: profile_path(current_user.profile),
        tags:       tags_path,
        search:     search_path,
        help:       help_path,
        sign_out:   destroy_user_session_path
      }
    else
      {
        home:    root_path,
        tags:    tags_path,
        search:  search_path,
        help:    help_path,
        sign_in: user_omniauth_authorize_path(:github)
      }
    end
  end

  # Public: Determine whether or not the current navigation item matches the
  #         current request.
  #
  # Returns a TrueClass or FalseClass.
  def navigation_item_matches_request?(key)
    case key
    when :my_profile
      current_user.profile.username == params[:username]
    when :tags
      request.path =~ /\A\/tags/
    else
      controller_name.to_sym == key
    end
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

  # Public: Google Analytics allows you to set Custom Variables. Custom
  #         variables are name-value pair tags that you can insert in your
  #         tracking code in order to refine Google Analytics tracking.
  #
  # Examples
  #
  #   # => [#<GoogleAnalytics::Events::SetCustomVar:0x007fb0c7b433c0
  #        @name="_setCustomVar",
  #        @params=[1, "profile_username", "", 2]>]
  #
  # Returns an Array of GA::Events.
  def google_analytics_events
    # The slot for the custom variable.
    index = 1
    # The name for the custom variable.
    name = "Profile Username"
    # The value for the custom variable.
    value = user_signed_in? ? current_user.profile.username : "anonymous"
    # The scope for the custom variable. 2 is session-level.
    scope = 2
    [GA::Events::SetCustomVar.new(index, name, value, scope)]
  end

  # Public: Find and memoize the slug for a hashtag.
  #
  # slug - The String slug for a specific Tag.
  #
  # Examples
  #
  #   hashtag_to_slug("#Rails")
  #   # => "rails"
  #
  # Returns a String of the Tag's slug.
  def hashtag_to_slug(hashtag)
    @memoized_slugs ||= {}

    unless @memoized_slugs[hashtag].present?
      @memoized_slugs[hashtag] = MyGists::Cache::Tags::Helper.slug_from_hashtag(hashtag)
    end

    @memoized_slugs[hashtag]
  end
end
