module MyGists

  # Public: Encapsulates logic for getting public entities like tags.
  #
  # Examples
  #
  #   MyGists::Public.tags(page)
  class Public

    # Public: Integer number of tags per page.
    TAGS_PER_PAGE = 120

    # Public: Gets, paginates and decorates public tags.
    #
    # page - The String or Integer of current page.
    #
    # Examples
    #
    #   MyGists::Public.tags(page)
    #   # => [#<ActsAsTaggableOn::Tag id: 1, name: "rails" slug: "rails">]
    #
    # Returns an Array of paginated and decorated ActsAsTaggableOn::Tags tags.
    def self.tags(page)
      options = { page: page, per_page: TAGS_PER_PAGE }
      ActsAsTaggableOn::Tag.public_tags.paginate(options).decorate
    end
  end
end
