class AddTokenToProfiles < ActiveRecord::Migration
  def change
    add_column(:profiles, :token, :text)
  end
end
