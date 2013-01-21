module MyGists

  # Public: Data for tags cache. A Duck for the MyGists::Cache role.
  #
  # Examples
  #
  #   MyGists::Cache::Tags.data
  class Cache::Tags

    # Public: Data for tags cache which is all Tags with status and slug.
    #
    # Examples
    #
    #   MyGists::Cache::Tags.data
    #   # => {"ActiveRecord"=>{:slug=>"activerecord", :public=>true}}
    #
    #   MyGists::Cache::Tags.data
    #   # => {"diff"=>{:slug=>"diff", :public=>false}}
    #
    # Returns a Hash of all Tags.
    def self.data
      new.all
    end

    # Public: Normalized key for cache data structure.
    #
    # tag_name - The tag name String used to set the key.
    #
    # Examples
    #
    #   key("Rails")
    #   # => "rails"
    #
    # Returns the String key.
    def self.key(tag_name)
      tag_name.downcase
    end

    # Public: Initialize a Tags.
    def initialize
      @tags = {}
      @public_ids = []
    end

    # Public: All Tags with status and slug.
    #
    # Examples
    #
    #   tags
    #   # => {"activerecord"=>{:name=>"ActiveRecord", :slug=>"activerecord", :public=>true}}
    #
    #   tags
    #   # => {"diff"=>{:name=>"diff", :slug=>"diff", :public=>false}}
    #
    # Returns a Hash of all Tags.
    def all
      public_tags
      private_tags
      @tags
    end

    private
    # Internal: Returns the Array of all public Tag IDs.
    attr_accessor :public_ids

    # Internal: Find all public tags. For each public tag, append it to the
    #           internal tags attribute. Each appended tag is as a Hash.
    #
    # Returns nothing.
    def public_tags
      ActsAsTaggableOn::Tag.public_tags.inject(@tags) do |public_tags, tag|

        public_ids << tag.id

        public_tags[self.class.key(tag.name)] = meta(tag.name, tag.slug, true)

        public_tags
      end
    end

    # Internal: Find all private tags. For each private tag, append it to the
    #           internal tags attribute. Each appended tag is as a Hash.
    #
    # Returns nothing.
    def private_tags
      ActsAsTaggableOn::Tag.not_in(public_ids).inject(@tags) do |private_tags, tag|

        private_tags[self.class.key(tag.name)] = meta(tag.name, tag.slug, false)

        private_tags
      end
    end

    # Internal: Data container for cache data structure value.
    #
    # name   - The String of the tag name.
    # slug   - The String of the tag slug.
    # status - The TrueClass or FalseClass or the tag status.
    #
    # Examples
    #
    #   meta
    #   # => { name: name, slug: slug, public: status }
    #
    # Returns the Hash data container.
    def meta(name, slug, status)
      # TODO
      # Use MyGists::Cache::Tags::Meta.
      # When the cache is fetched, an error is thrown:
      #   "undefined class/module MyGists::Cache::Tags::Meta"
      # The class is not being autoloaded.
      # A fix has been accepted, but it has not been released.
      # See https://github.com/rails/rails/issues/8167
      { name: name, slug: slug, public: status }
      # MyGists::Cache::Tags::Meta.new(name, slug, status)
    end
  end
end
