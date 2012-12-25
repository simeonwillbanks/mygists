class AddIndexes < ActiveRecord::Migration
  def up
    add_index(:gists, :profile_id)
    add_index(:profiles, :username)
    add_index(:profiles, :user_id)
    add_index(:users, [:provider, :uid], unique: true)
  end

  def down
    remove_index(:gists, :profile_id)
    remove_index(:profiles, :username)
    remove_index(:profiles, :user_id)
    remove_index(:users, [:provider, :uid])
  end
end
