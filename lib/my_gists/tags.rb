module MyGists
  class Tags

    class << self
      protected :new
    end

    def self.for(gist)
      new(gist) do
        return tags
      end
    end

    def initialize(gist, &block)
      @description = gist.description
      instance_eval(&block) if block_given?
    end

    private
    attr_reader :description

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
