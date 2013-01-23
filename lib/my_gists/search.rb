module MyGists

  # Public: Search tags, or search gists by tag and profile. Respond with an
  #         Enumerable which wraps an Array of decorated Gists or Tags.
  #
  # Examples
  #
  #   MyGists::Search.for(:tags)
  #
  #   MyGists::Search.for(:tags, page: 1)
  #
  #   MyGists::Search.for(:tags, page: 1, private: false)
  #
  #   MyGists::Search.for(:tags, page: 1, profile: profile)
  #
  #   MyGists::Search.for(:tags, page: 1, profile: profile, private: false)
  #
  #   MyGists::Search.for(:gists)
  #
  #   MyGists::Search.for(:gists, page: 1)
  #
  #   MyGists::Search.for(:gists, page: 1, private: false)
  #
  #   MyGists::Search.for(:gists, page: 1, tag: tag)
  #
  #   MyGists::Search.for(:gists, page: 1, tag: tag, private: false)
  #
  #   MyGists::Search.for(:gists, page: 1, tag: tag, profile: profile)
  #
  #   MyGists::Search.for(:gists, page: 1, tag: tag, profile: profile, private: false)
  class Search

    include Enumerable

    # Public: Expose WillPaginate API from scope.
    delegate :current_page, :per_page, :offset, :total_entries, :total_pages, to: :scope

    class << self
      # Internal: Only Search.for can initialize a new Search.
      protected :new
    end

    # Public: Search for either gists or tags. Refine search results by
    #         options such as tag, profile and status. Search result set is a
    #         collection of decorated gists or tags.
    #
    # resource - The Symbol of which resource to search for. The Symbol should
    #            be either :gists or :tags.
    # options -  The Hash options used to refine the search (default: {}):
    #            :tag     - Tag or String of tag name (optional).
    #            :page    - Integer for page of collection (optional).
    #            :profile - Profile or String who owns resources (optional).
    #            :private - TrueClass or FalseClass used to exclude private
    #                       resources from search results (optional).
    #
    # Examples
    #
    #   MyGists::Search.for(:tags, profile: profile).to_a
    #   # => [#<ActsAsTaggableOn::Tag id: 183, name: "JavaScript", slug: "javascript">,
    #         #<ActsAsTaggableOn::Tag id: 182, name: "Without Tags", slug: "without-tags">]
    #
    #   MyGists::Search.for(:gists, tag: tag, profile: profile).to_a
    #   # => [#<Gist id: 502, description: "Delete all notifications button #github"...>]
    #
    # Returns an Enumerable which wraps an Array of decorated Gists or Tags.
    def self.for(resource, options = {})
      new(options) { send(resource) }
    end

    # Public: Initialize a Search.
    #
    # options - The Hash options used to refine the search:
    #           :tag     - Tag or String of tag name (optional).
    #           :page    - Integer for page of collection (optional).
    #           :profile - Profile who owns resources (optional).
    #           :private - TrueClass or FalseClass used to exclude private
    #                      resources from search results (optional).
    #
    # Yields within context of self.
    def initialize(options, &block)
      @page = options.delete(:page)
      @include_private = options.fetch(:private, true)

      profile_option = options.delete(:profile)
      @profile = if profile_option.is_a?(String) && profile_option.present?
                   # When a profile search term exists, we only want to
                   # perform a search if we find a Profile. If we don't find
                   # a Profile, an empty Profile instance is used in the
                   # scope, and no gists will be found.
                   Profile.find_or_initialize_by_username(profile_option)
                 else
                   profile_option
                 end

      tag_option = options.delete(:tag)
      @tag_name = tag_option.respond_to?(:name) ? tag_option.name : tag_option

      instance_eval(&block) if block_given?
    end

    # Public: Method required by Enumerable. Iterates resources found by the
    #         scope and decorates each resource.
    #
    # Yields a decorated resource.
    def each(&block)
      scope.each { |resource| block.call(resource.decorate) }
    end

    # Public: Whether or not our search result set is empty.
    #
    # Returns a TrueClass or FalseClass depending on existence of result set.
    def empty?
      scope.size == 0
    end

    private
    # Internal: Returns the Integer for page of collection from received options.
    attr_reader :page

    # Internal: Returns the Profile from received options.
    attr_reader :profile

    # Internal: Returns the TrueClass or FalseClass used to exclude private
    #           resources from search results.
    attr_reader :include_private

    # Internal: Returns the String tag name from received options.
    attr_reader :tag_name

    # Internal: Returns the current ActiveRecord query object.
    attr_reader :scope

    # Internal: Build a tags scope based on profile, tag_name and
    #           include_private attributes.
    #
    # Returns nothing.
    def tags
      if profile.present? && tag_name.present?
        scope = profile.owned_tags.by_name(tag_name)
      elsif profile.present? && tag_name.blank?
        scope = profile.owned_tags
      elsif profile.blank? && tag_name.present?
        scope = ActsAsTaggableOn::Tag.by_name(tag_name)
      else
        scope = ActsAsTaggableOn::Tag.scoped
      end

      scope = scope.only_public unless include_private

      @scope = scope
    end

    # Internal: Build a gists scope based on profile, tag_name and
    #           include_private attributes.
    #
    # Returns nothing.
    def gists
      if profile.present? && tag_name.present?
        scope = profile.gists.tagged_with(tag_name)
      elsif profile.present? && tag_name.blank?
        scope = profile.gists
      elsif profile.blank? && tag_name.present?
        scope = Gist.tagged_with(tag_name).includes(:profile)
      else
        scope = Gist.scoped.includes(:profile)
      end

      scope = scope.only_public unless include_private

      scope = scope.page(page)

      @scope = scope
    end
  end
end
