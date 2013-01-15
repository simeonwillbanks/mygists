class AddGravatarIdToProfiles < ActiveRecord::Migration
  def change
    add_column(:profiles, :gravatar_id, :string)
  end
end
