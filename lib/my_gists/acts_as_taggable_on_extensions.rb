module MyGists

  # Public: Mixin for defining MyGists custom ActsAsTaggableOn::Tag
  #         functionality.
  module ActsAsTaggableOnExtensions
    extend ActiveSupport::Concern

    included do

      # Public: String of default tag.
      DEFAULT = "Without Tags"

      # Public: String of public tagging context for tag.
      CONTEXT_PUBLIC = "public"

      # Public: String of private tagging context for tag.
      CONTEXT_PRIVATE = "private"

      extend ::FriendlyId
      friendly_id :name, use: :slugged

      validates_presence_of :name, :slug

      default_scope order("\"#{table_name}\".\"slug\" ASC")

      # Public: Find tagged objects within the 'public' context.
      scope :only_public, where("\"taggings\".\"context\" = '#{CONTEXT_PUBLIC}'")

      # Public: Find a tag by its name.
      def self.by_name(name)
        where(name: name)
      end

      # Public: Creates a slug for a tag from received value. If the value is
      #         not sluggable, use a default slug.
      #
      # value - The String to be slugged.
      #
      # Examples
      #
      #   normalize_friendly_id("bar foo")
      #   # => "bar-foo"
      #
      #   normalize_friendly_id("$")
      #   # => "--1"
      #
      # Returns a String for the slug.
      def normalize_friendly_id(value)
        normalized = value.to_s.parameterize
        normalized = friendly_id_config.sequence_separator unless normalized.present?
        normalized
      end

      # Public: When the tag's name matches the constant default, the tag is
      #         the default! Otherwise, it is not the default.
      #
      # Examples
      #
      #   default?
      #   # => true
      #
      #   default?
      #   # => false
      #
      # Returns A TrueClass or FalseClass.
      def default?
        name == DEFAULT
      end
    end

    module ClassMethods

      # Public: A public API to get the default tag.
      #
      # Examples
      #
      #   ActsAsTaggableOn::Tag.default
      #   # => "Without Tag"
      #
      # Returns a String of the default tag.
      def default
        DEFAULT
      end

      # Public: A public API to get the various tag contexts.
      #
      # context - The Symbol used to match a context constant
      #
      # Examples
      #
      #   ActsAsTaggableOn::Tag.context(:public)
      #   # => "public"
      #
      #   ActsAsTaggableOn::Tag.context(:private)
      #   # => "private"
      #
      # Returns a String of the tag context.
      def context(context)
        case
        when context == :public
          CONTEXT_PUBLIC
        when context == :private
          CONTEXT_PRIVATE
        end
      end
    end
  end

  ActsAsTaggableOn::Tag.send(:include, ActsAsTaggableOnExtensions)
end
