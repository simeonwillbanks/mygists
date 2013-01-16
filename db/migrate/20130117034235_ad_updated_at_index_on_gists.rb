class AdUpdatedAtIndexOnGists < ActiveRecord::Migration
  def up
    add_index(:gists, :updated_at)
  end

  def down
    remove_index(:gists, :updated_at)
  end
end
