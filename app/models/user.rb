class User < ActiveRecord::Base
  validates_presence_of :provider, :uid

  devise :omniauthable

  has_one :profile

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.new do |u|
        u.provider = auth.provider
        u.uid      = auth.uid
        u.profile  = Profile.new {|p| p.username = auth.info.nickname}
      end
      user.save
    end
    user.profile.gravatar = auth.info.image
    user
  end
end
