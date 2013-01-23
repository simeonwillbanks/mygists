class ActsAsTaggableOn::TagDecorator < ApplicationDecorator

  # Public: When the tag is the default, do not prepend a "#" to the tag name.
  #         Otherwise, prepend each tag name with a "#".
  #
  # Examples
  #
  #   name
  #   # => "Without Tags"
  #
  #   name
  #   # => "#Rails"
  #
  # Returns the tag name String.
  def name
    source.default? ? source.name : "##{source.name}"
  end

  # Public: When the tag is the default, its button should be different from
  #         regular tags. Therefore, use different Bootstrap button classnames
  #         for default and regular tags.
  #
  # Examples
  #
  #   classname
  #   # => "btn"
  #
  #   classname
  #   # => "btn btn-success"
  #
  # Returns the tag classname String.
  def classname
    source.default? ? "btn" : "btn btn-success"
  end

  def to_s
    name
  end
end
