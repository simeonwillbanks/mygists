class TagsNameSlugNullFalse < ActiveRecord::Migration
  def up
    change_column(:tags, :name, :string, null: false)
    change_column(:tags, :slug, :string, null: false)
  end

  def down
    change_column(:tags, :name, :string)
    change_column(:tags, :slug, :string)
  end
end
