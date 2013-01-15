class Gist < ActiveRecord::Base
  default_scope order("\"#{table_name}\".\"created_at\" DESC")

  validates_presence_of :gid

  belongs_to :profile

  acts_as_taggable_on :descriptions

  # Public: Find the most recently updated gist.
  scope :last_touched, reorder("\"#{table_name}\".\"updated_at\" DESC").limit(1)

  # Public: Find only public gists.
  scope :only_public, where(public: true)

  # Public: For a specific profile, find its last updated gist.
  #
  # profile_id - The Integer ID of a profile.
  #
  # Examples
  #
  #   Gist.last_touched_for(1)
  #   # => #<Gist id: 532 ...>
  #
  #   Gist.last_touched_for(1)
  #   # => nil
  #
  # Returns a NilClass or an instance of a Gist.
  def self.last_touched_for(profile_id)
    last_touched.where(profile_id: profile_id).first
  end
end
