class AddStarredToGists < ActiveRecord::Migration
  def change
    add_column :gists, :starred, :boolean, default: false
  end
end
