module MyGists

  # Public: A simple wrapper around ActiveSupport::Cache::Store with an
  #         interface for reading and writing cache to current cache store.
  #
  # Examples
  #
  #   MyGists::Cache.read(:profiles)
  #
  #   MyGists::Cache.write(:profiles)
  class Cache

    # Public: If a cache expires, and due to heavy load, different processes
    #         will try to read data natively and then they all will try to
    #         write to cache. To avoid that case the first process to find an
    #         expired cache entry will bump the cache expiration time by the
    #         value set in RACE_CONDITION_TTL.
    RACE_CONDITION_TTL = 10

    # Public: Set an expiration time on the cache.
    EXPIRES_IN = 15.minutes

    # Public: A custom expection which is thrown when cache can not be written
    #         for a specific key.
    class InvalidCacheKey < StandardError; end

    # Public: Fetches data from the cache, using the given key. If there is
    #         data in the cache with the given key, then that data is returned.
    #         If there is no such data in the cache (a cache miss), a block
    #         will be run. The return value of the block will be written to
    #         the cache under the given cache key, and that return value will
    #         be returned. If the cache is under heavy load, expiration will
    #         be delayed. See RACE_CONDITION_TTL for more details.
    #
    # key - The Symbol cache key.
    #
    # Examples
    #
    #   MyGists::Cache.read(:profiles)
    #   # => ["username"]
    #
    # Returns the data from the cache.
    def self.read(key)
      Rails.cache.fetch(key, race_condition_ttl: RACE_CONDITION_TTL) do
        source(key)
      end
    end

    # Public: Writes the value to the cache, with the key. Cache will expire
    #         in a specific number of seconds. The number of seconds is
    #         defined by EXPIRES_IN constant.
    #
    # key - The Symbol cache key.
    #
    # Examples
    #
    #   MyGists::Cache.write(:profiles)
    #
    # Returns nothing.
    def self.write(key)
      Rails.cache.write(key, source(key), expires_in: EXPIRES_IN)
    end

    # Public: Source data for cache, using the given key. The data may come
    #         from a model or elsewhere. Each key can define the exact source
    #         of the data. If the key can not find any source data, a
    #         InvalidCacheKey exception is raised.
    #
    # key - The Symbol cache key.
    #
    # Examples
    #
    #   MyGists::Cache.source(:profiles)
    #   # => ["username"]
    #
    # Returns the data for the cache.
    # Raises MyGists::Cache::InvalidCacheKey if source data is not found.
    def self.source(key)
      begin
        "MyGists::Cache::#{key.to_s.camelize}".constantize.data
      rescue NameError
        raise InvalidCacheKey
      end
    end
  end
end
