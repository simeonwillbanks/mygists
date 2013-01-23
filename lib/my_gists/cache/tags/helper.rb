module MyGists

  # Public: Get a cached tag metadata from the tags cache.
  #
  # Examples
  #
  #   MyGists::Cache::Tags::Helper.slug_from_hashtag("#Rails")
  class Cache::Tags::Helper

    # Public: Get a cached slug for a given hashtag from the tags cache.
    #
    # hashtag - The String of the hashtag used to get its corresponding slug.
    #
    # Examples
    #
    #   MyGists::Cache::Tags::Helper.slug_from_hashtag("#Rails")
    #   # => "rails"
    #
    #   MyGists::Cache::Tags::Helper.slug_from_hashtag("#IDontExist")
    #   # => nil
    #
    # Returns a String of the slug or NilClass.
    def self.slug_from_hashtag(hashtag)
      tag_name = hashtag[1..-1]
      new(tag_name).slug
    end

    # Public: Returns the String cache key.
    attr_reader :key

    # Public: Returns the String tag name.
    attr_reader :tag_name

    # Public: Initialize a Helper.
    #
    # tag_name - A String tag name used to find tag cache.
    def initialize(tag_name)
      @tag_name = tag_name
      @key = MyGists::Cache::Tags.key(tag_name)
    end

    # Public: When a tag exists, get its slug from the cache. If the tag does
    #         not exist, return nil.
    #
    # Examples
    #
    #   slug
    #   # => "rails"
    #
    #   slug
    #   # => nil
    #
    # Returns a String of the slug or NilClass.
    def slug
      fetch[:slug]
    rescue NoMethodError
      nil
    end

    private
    # Internal: Fetch tag cache entry via key attribute. If there is a miss,
    #           look in the database by the tag name.
    #
    # Examples
    #
    #   fetch
    #   # => {:name=>"ActiveRecord", :slug=>"activerecord", :public=>true}
    #
    #   fetch
    #   # => #<ActsAsTaggableOn::Tag id: 1, name: "rails", slug: "rails">
    #
    # Returns a Hash of the cached tag or an instance of Tag.
    def fetch
      cache.fetch(key) do
        ActsAsTaggableOn::Tag.find_by_name(tag_name)
      end
    end

    # Internal: Read the tags cache.
    #
    # Examples
    #
    #   cache
    #   # => {"activerecord"=>{:name=>"ActiveRecord", :slug=>"activerecord", :public=>true}}
    #
    # Returns a Hash of the tags cache.
    def cache
      MyGists::Cache.read(:tags)
    end
  end
end
