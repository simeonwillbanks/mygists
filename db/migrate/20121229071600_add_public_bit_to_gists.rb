class AddPublicBitToGists < ActiveRecord::Migration
  def change
    add_column :gists, :public, :boolean, default: nil
  end
end
