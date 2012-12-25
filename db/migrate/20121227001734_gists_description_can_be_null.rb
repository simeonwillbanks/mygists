class GistsDescriptionCanBeNull < ActiveRecord::Migration
  def up
    change_column(:gists, :description, :string, null: true)
  end

  def down
    change_column(:gists, :description, :string, null: false)
  end
end
