module MyGists
  class Tags
    DEFAULT = 'Uncategorized'

    class << self
      protected :new

      def for(gist)
        new(gist) do
          return tags
        end
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
      tags << DEFAULT if tags.empty?
      tags
    end
  end
end
