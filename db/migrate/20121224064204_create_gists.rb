class CreateGists < ActiveRecord::Migration
  def change
    create_table :gists do |t|
      t.string :title, null: false
      t.integer :profile_id, null: false
      t.string :gid, null: false

      t.timestamps
    end
  end
end
