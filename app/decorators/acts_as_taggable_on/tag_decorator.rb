class ActsAsTaggableOn::TagDecorator < Draper::Base
  decorates :tag, class: "ActsAsTaggableOn::Tag"

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
    model.default? ? model.name : "##{model.name}"
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
    model.default? ? "btn" : "btn btn-success"
  end

  def to_s
    name
  end

  # Accessing Helpers
  #   You can access any helper via a proxy
  #
  #   Normal Usage: helpers.number_to_currency(2)
  #   Abbreviated : h.number_to_currency(2)
  #
  #   Or, optionally enable "lazy helpers" by including this module:
  #     include Draper::LazyHelpers
  #   Then use the helpers with no proxy:
  #     number_to_currency(2)

  # Defining an Interface
  #   Control access to the wrapped subject"s methods using one of the following:
  #
  #   To allow only the listed methods (whitelist):
  #     allows :method1, :method2
  #
  #   To allow everything except the listed methods (blacklist):
  #     denies :method1, :method2

  # Presentation Methods
  #   Define your own instance methods, even overriding accessors
  #   generated by ActiveRecord:
  #
  #   def created_at
  #     h.content_tag :span, attributes["created_at"].strftime("%a %m/%d/%y"),
  #                   :class => "timestamp"
  #   end
end
