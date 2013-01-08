class Gist < ActiveRecord::Base
  default_scope order("\"#{table_name}\".\"created_at\" DESC")

  validates_presence_of :gid

  belongs_to :profile

  acts_as_taggable_on :descriptions

  scope :last_touched, reorder("\"#{table_name}\".\"updated_at\" DESC").limit(1)

  def self.public_null_for(profile_id)
    where(profile_id: profile_id, public: nil).first
  end

  def self.last_touched_for(profile_id)
    last_touched.where(profile_id: profile_id).first
  end

  def self.find_page_by_tag_name_and_profile(page, tag_name, profile)
    Gist.tagged_with(tag_name, on: :descriptions, owned_by: profile).page(page)
  end
end
