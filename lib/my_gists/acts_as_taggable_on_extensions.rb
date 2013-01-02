module MyGists
  module ActsAsTaggableOnExtensions
    extend ActiveSupport::Concern

    included do
      DEFAULT = 'Without Tags'

      default_scope order("\"#{table_name}\".\"slug\" ASC")

      extend ::FriendlyId
      friendly_id :name, use: :slugged
      validates_presence_of :name, :slug

      def normalize_friendly_id(value)
        normalized = value.to_s.parameterize
        normalized = friendly_id_config.sequence_separator unless normalized.present?
        normalized
      end

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
