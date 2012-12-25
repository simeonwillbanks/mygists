module MyGists
  module ActsAsTaggableOnExtensions
    extend ActiveSupport::Concern

    included do
      default_scope order("\"#{table_name}\".\"name\" ASC")
    end
  end

  ActsAsTaggableOn::Tag.send(:include, ActsAsTaggableOnExtensions)
end
