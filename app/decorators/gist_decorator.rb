class GistDecorator < ApplicationDecorator

  # Public: Delegate certain methods from the decorator to the source model.
  delegate :profile

  # Public: String of default description text.
  DEFAULT_DESCRIPTION = "Gist without a description"

  # Public: Builds the icon HTML (starred, public or private) from the gist
  #         state. Plus, appended a GitHub icon which links to gist on GitHub.
  #
  # Examples
  #
  #   icons
  #   # => "<i class=\"icon-star\"></i><i class="\icon-ok-sign\"></i><a href=\"https://gist.github.com/4\" target=\"_blank\"><i class=\"icon-github\"></i></a>"
  #
  #   icons
  #   # => "<i class=\"icon-ok-sign\"></i><a href=\"https://gist.github.com/4\" target=\"_blank\"><i class=\"icon-github\"></i></a>"
  #
  # Returns the gist icon HTML String.
  def icons
    icons = []

    if source.starred?
      icons << h.content_tag(:i, nil, class: "icon-star")
    end

    if source.public?
      icons << h.content_tag(:i, nil, class: "icon-ok-sign")
    else
      icons << h.content_tag(:i, nil, class: "icon-lock")
    end

    icons << h.link_to(url, target: "_blank") do
      h.content_tag(:i, nil, class: "icon-github")
    end

    icons.join("").html_safe
  end

  # Public: Build a link back to the gist on GitHub.
  #
  # Examples
  #
  #   url
  #   # => "https://gist.github.com/3183191"
  #
  # Returns the gist url String.
  def url
    "#{GitHub.gist_page}/#{source.gid}"
  end

  # Public: The view needs a description to provide text for an anchor
  #         tag which links back to GitHub. Therefore, when a description is
  #         empty, a default should be used. Otherwise, use the gist's
  #         description. Also, we linkify any tag text.
  #
  # Examples
  #
  #   description
  #   # => "Gist without a description"
  #
  #   description
  #   # => "A gist about <span class=\"text-success\">#Rails</span>"
  #
  # Returns the gist description String.
  def description
    description = source.description? ? source.description : DEFAULT_DESCRIPTION

    linkify_tags(description).html_safe
  end

  private
  # Internal: Linkify gist description tags. Given a gist description,
  #           search for all tags, and wrap the tags in a HTML anchor and
  #           highlight tag unless the found tag does not have a slug.
  #
  # Examples
  #
  #   linkify_tags(description)
  #   # => "Gist without a tag"
  #
  #   linkify_tags(description)
  #   # => "A gist about <a href="/tags/rails"><span class=\"text-success\">#Rails</span></a>"
  #
  #   linkify_tags(description)
  #   # => "A gist about a #TagWithOutASlug"
  #
  # Returns the description String.
  def linkify_tags(description)
    description.gsub(/(#[^\s]+)/) do |hashtag|

      if (slug = h.hashtag_to_slug(hashtag))

        h.link_to(h.tag_path(slug: slug)) do

          h.content_tag(:span, hashtag, class: "text-success")
        end

      else
        hashtag
      end
    end
  end
end
