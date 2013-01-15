module MyGists

  # Public: Extracts tags from received gist.
  #
  # Examples
  #
  #   MyGists::Tags.for(gist)
  class Tags

    class << self
      # Internal: Only Tags.for can initialize a new Fetch.
      protected :new
    end

    # Public: Extracts tags from received gist.
    #
    # gist - The Gist whose description will be searched for tags.
    #
    # Examples
    #
    #   MyGists::Tags.for(gist)
    #   # => ["Rails", "Ruby"]
    #
    # Returns An array of extracted String tags.
    def self.for(gist)
      new(gist) do
        return tags
      end
    end

    # Public: Initialize a Tags.
    #
    # gist - The Gist whose description will be searched for tags.
    #
    # Yields within context of self.
    def initialize(gist, &block)
      @description = gist.description
      instance_eval(&block) if block_given?
    end

    private
    # Internal: Returns the String description of Gist.
    attr_reader :description

    # Internal: Scans description attribute for #hashtags and extracts each
    #           #hashtag into a tag String. If no #hashtags are found, the
    #           default tag is returned.
    #
    # Examples
    #
    #   tags
    #   # => ["Rails", "Ruby"]
    #
    #   tags
    #   # => ["Without Tags"]
    #
    # Returns An array of extracted String tags.
    def tags
      tags = []

      unless description.blank?
        description.scan(/#([^\s]+)/) do |m|
          tags << m[0]
        end
      end

      tags << ActsAsTaggableOn::Tag.default if tags.empty?
      tags
    end
  end
end
