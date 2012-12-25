class User < ActiveRecord::Base
  validates_presence_of :provider, :uid, :profile

  devise :omniauthable

  has_one :profile

  class << self
    def find_for_github_oauth(auth, signed_in_resource=nil)
      find_or_create_by_provider_and_uid(auth.provider, auth.uid).tap do |u|
        u.profile = Profile.find_or_create_by_user_id(u.id).tap do |p|
          p.username = auth.info.nickname
        end
        u.save!
      end
    end
  end
end
