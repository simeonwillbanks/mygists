class AlterGistRenameTitleToDescription < ActiveRecord::Migration
  def up
    rename_column(:gists, :title, :description)
  end

  def down
    rename_column(:gists, :description, :title)
  end
end
