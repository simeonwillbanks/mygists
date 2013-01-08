class User < ActiveRecord::Base
  validates_presence_of :provider, :uid, :profile

  devise :omniauthable

  has_one :profile

  def self.find_for_github_oauth(auth, signed_in_resource = nil)
    find_or_create_by_provider_and_uid(auth.provider, auth.uid).tap do |u|

      u.profile = Profile.find_or_create_by_user_id(u.id).tap do |p|
        p.username = auth.info.nickname
        p.token = MyGists::Secure.encrypt(auth.credentials.token)
      end

      u.save! if u.new_record? || u.changed?

      u.profile.save! if u.profile.new_record? || u.profile.changed?
    end
  end
end
