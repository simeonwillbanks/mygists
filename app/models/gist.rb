class Gist < ActiveRecord::Base

  # Public: Default title for a gist, when the gist's title can not be
  #         retrieved.
  DEFAULT_TITLE = "gistfile1.txt"

  # Public: Regex to match String of default title text.
  DEFAULT_TITLE_REGEX = /\Agistfile1/

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

  # Public: A public API to get the default title.
  #
  # Examples
  #
  #   Gist.default_title
  #   # => "gistfile1.txt"
  #
  # Returns a String of the default title.
  def self.default_title
    DEFAULT_TITLE
  end

  # Public: A public API to get the default title regex.
  #
  # Examples
  #
  #   Gist.default_title_regex
  #   # => /\Agistfile1/
  #
  # Returns a Regexp to match the default title.
  def self.default_title_regex
    DEFAULT_TITLE_REGEX
  end
end
