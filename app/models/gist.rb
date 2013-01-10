class Gist < ActiveRecord::Base
  default_scope order("\"#{table_name}\".\"created_at\" DESC")

  validates_presence_of :gid

  belongs_to :profile

  acts_as_taggable_on :descriptions

  scope :last_touched, reorder("\"#{table_name}\".\"updated_at\" DESC").limit(1)

  # Public: For a specific profile, find a gist with its public status set to
  #         NULL.
  #
  # profile_id - The Integer ID of a profile.
  #
  # Examples
  #
  #   Gist.public_null_for(1)
  #   # => #<Gist id: 532 ...>
  #
  #   Gist.public_null_for(1)
  #   # => nil
  #
  # Returns a NilClass or an instance of a Gist.
  def self.public_null_for(profile_id)
    where(profile_id: profile_id, public: nil).first
  end

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
  def self.public_null_for(profile_id)
    where(profile_id: profile_id, public: nil).first
  end

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
