module MyGists
  module ActsAsTaggableOnExtensions
    extend ActiveSupport::Concern

    included do
      DEFAULT = 'Without Tags'

      default_scope order("\"#{table_name}\".\"name\" ASC")

      def default?
        name == DEFAULT
      end
    end

    module ClassMethods
      def default
        DEFAULT
      end
    end
  end

  ActsAsTaggableOn::Tag.send(:include, ActsAsTaggableOnExtensions)
end
