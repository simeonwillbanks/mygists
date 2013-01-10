class Profile < ActiveRecord::Base
  validates_presence_of :username, :user

  belongs_to :user
  has_many   :gists

  acts_as_tagger

  # Public: Overloads the token reader, so the token can be decrypted before
  #         being returned.
  #
  # Examples
  #
  #   token
  #   # => "password"
  #
  # Returns a String of the token.
  def token
    MyGists::Secure.decrypt(self[:token])
  end

  # Public: Overloads ActiveModel to_param, so username will be used for the
  #         parameter instead of id. If the Profile is not saved, return nil.
  #         Otherwise, return the username.
  #
  # Examples
  #
  #   to_param
  #   # => "simeonwillbanks"
  #
  #   to_param
  #   # => nil
  #
  # Returns a NilClass or a String of the username.
  def to_param
    persisted? ? username : nil
  end
end
