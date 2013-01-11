# Public: A simple data container to house static Gravatar urls.
#
# Examples
#
#   Gravatar.url("a624cb08e20db3ac4adb6380928a7b11")
#   # => "https://secure.gravatar.com/avatar/a624cb08e20db3ac4adb6380928a7b11?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png&s=90"
class Gravatar

  # Public: Gravatar service secure host and url path.
  HOST_AND_PATH = "https://secure.gravatar.com/avatar/"

  # Public: Gravatar service query string with GitHub png as default image
  #         and size set to 90 pixels.
  QUERY_STRING  = "?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png&s=90"

  # Public: Gravatar secure url from a gravatar ID.
  #
  # Examples
  #
  #   Gravatar.url("a624cb08e20db3ac4adb6380928a7b11")
  #   # => "https://secure.gravatar.com/avatar/a624cb08e20db3ac4adb6380928a7b11?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png&s=90"
  #
  # Returns a String of Gravatar secure url.
  def self.url(id)
    "#{HOST_AND_PATH}#{id}#{QUERY_STRING}"
  end
end
