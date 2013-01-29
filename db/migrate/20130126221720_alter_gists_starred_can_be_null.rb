class AlterGistsStarredCanBeNull < ActiveRecord::Migration
  def up
    change_column(:gists, :starred, :boolean, default: nil)
  end

  def down
    change_column(:gists, :starred, :boolean, default: false)
  end
end
