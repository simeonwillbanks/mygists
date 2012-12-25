class AddUniqueConstraintToGists < ActiveRecord::Migration
  def change
    add_index(:gists, :gid, unique: true)
  end
end
