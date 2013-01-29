class User < ActiveRecord::Base
  validates_presence_of :provider, :uid, :profile

  devise :omniauthable

  has_one :profile, dependent: :destroy

  # Public: A method called by Users::OmniauthCallbacksController#github which
  #         tires to find an existing user by GitHub uid or create one. Once
  #         the user is found, the user's profile is updated with their GitHub
  #         username and OAuth token.
  #
  # auth               - All information retrieved from GitHub by OmniAuth as
  #                      a Hash.
  # signed_in_resource - An instance of the signed in User or nil.
  #
  # Returns an instance of User.
  def self.find_for_github_oauth(auth, signed_in_resource = nil)
    find_or_create_by_provider_and_uid(auth.provider, auth.uid).tap do |u|

      u.profile = Profile.find_or_create_by_user_id(u.id).tap do |p|
        p.gravatar_id = auth.extra.raw_info.gravatar_id
        p.username = auth.extra.raw_info.login
        p.token = MyGists::Secure.encrypt(auth.credentials.token)
      end

      u.save! if u.new_record? || u.changed?

      u.profile.save! if u.profile.new_record? || u.profile.changed?
    end
  end
end
