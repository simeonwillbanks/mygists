module MyGists
  class Tag
    DEFAULT = 'Uncategorized'

    class << self
      protected :new

      def for(gist)
        new(gist) do
          return tag
        end
      end
    end

    def initialize(gist, &block)
      @description = gist.description
      instance_eval(&block) if block_given?
    end

    private

    attr_reader :description

    def tag
      tag = DEFAULT
      unless description.blank?
        description.match(/([^:]+):/) do |m|
          tag = m[1]
        end
      end
      tag
    end
  end
end
