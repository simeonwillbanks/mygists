class AlterGistsDescription < ActiveRecord::Migration
  def up
    change_column(:gists, :description, :text)
  end

  def down
    change_column(:gists, :description, :string)
  end
end
