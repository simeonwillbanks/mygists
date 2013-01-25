class GistDecorator < ApplicationDecorator

  # Public: Delegate certain methods from the decorator to the source model.
  delegate :profile

  # Public: Builds the icon HTML (starred or private) from the gist
  #         state.
  #
  # Examples
  #
  #   icons
  #   # => "<i class=\"icon-star\"></i>"
  #
  #   icons
  #   # => "<i class=\"icon-star\"></i><i class=\"icon-lock\"></i>
  #
  # Returns the gist icon HTML String.
  def icons
    icons = []

    icons << h.content_tag(:i, nil, class: "icon-star") if source.starred?

    icons << h.content_tag(:i, nil, class: "icon-lock") unless source.public?

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

  # Public: The view needs a title to provide text for an anchor
  #         tag which links back to GitHub. Therefore, when the title is the
  #         default, build default text just like GitHub: gist:4630341.
  #
  # Examples
  #
  #   title
  #   # => "gist:4630341"
  #
  #   title
  #   # => "settings.yml"
  #
  # Returns the gist title String.
  def title
    h.link_to(url, target: "_blank") do
      source.title =~ source.class.default_title_regex ? default_title : source.title
    end
  end


  # Public: When a description is empty, nil is returned. Otherwise, use the
  #         gist's description. Also, we linkify any tag text.
  #
  # Examples
  #
  #   description
  #   # => nil
  #
  #   description
  #   # => "<p>A gist about <span class=\"tag\">#Rails</span></p>"
  #
  # Returns the gist description String or NilClass.
  def description
    h.content_tag(:p, linkify_tags(source.description).html_safe) if source.description?
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
  #   # => "A gist about <a href="/tags/rails"><span class=\"tag\">#Rails</span></a>"
  #
  #   linkify_tags(description)
  #   # => "A gist about a #TagWithOutASlug"
  #
  # Returns the description String.
  def linkify_tags(description)
    description.gsub(/(#[^\s]+)/) do |hashtag|

      if (slug = h.hashtag_to_slug(hashtag))

        h.link_to(h.tag_path(slug: slug)) do

          h.content_tag(:span, hashtag, class: "tag")
        end

      else
        hashtag
      end
    end
  end

  # Internal: A default gist title for views.
  #
  # Examples
  #
  #   default_title
  #   # => "gist:1012967"
  #
  # Returns the default title String.
  def default_title
    "gist:#{source.gid}"
  end
end
