class ProfileDecorator < ApplicationDecorator

  # Public: Delegate certain methods from the decorator to the source model.
  delegate :username, :user_id

  # Public: Build an image tag with profiles gravatar url as the source, and
  #         links the image to the users GitHub profile page.
  #
  # Returns String HTML anchor wrapped image tag.
  def gravatar
    anchor_title = "#{source.username} GitHub Profile"
    github_url = GitHub.profile_page(source.username)
    gravatar_url = Gravatar.url(source.gravatar_id)

    h.link_to(github_url, title: anchor_title) do

      h.image_tag(gravatar_url, alt: source.username,
                                width: 90,
                                height: 90,
                                class: "img-polaroid")
    end
  end

  private
  # Internal: Extract and memoize GitHub session key/value pairs.
  #
  # Examples
  #
  #   github
  #   # => { :gravatar => "https://1.gravatar.com/avatar/767fc9c115a1b989744c755db47feb60?s=200&r=pg&d=mm" }
  #
  #   github
  #   # => {}
  #
  # Returns Hash of GitHub session.
  def github
    @github ||= if h.user_signed_in?
                  h.user_session.fetch(:github, {})
                else
                  {}
                end
  end
end
