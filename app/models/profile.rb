class Profile < ActiveRecord::Base
  validates_presence_of :username, :user

  belongs_to :user
  has_many   :gists

  acts_as_tagger

  def to_param
    persisted? ? username : nil
  end
end
