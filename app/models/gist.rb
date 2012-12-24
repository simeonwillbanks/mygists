class Gist < ActiveRecord::Base
  default_scope order("\"#{table_name}\".\"created_at\" DESC")

  validates_presence_of :title, :gid

  belongs_to :profile

  acts_as_taggable_on :titles
end
