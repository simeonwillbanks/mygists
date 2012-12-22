class Profile < ActiveRecord::Base
  attr_accessor :gravatar

  validates_presence_of :username, :user

  belongs_to :user

  def to_param
    persisted? ? username : nil
  end
end
