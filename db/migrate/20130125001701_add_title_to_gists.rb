class AddTitleToGists < ActiveRecord::Migration
  def change
    add_column :gists, :title, :text, after: :id
  end
end
