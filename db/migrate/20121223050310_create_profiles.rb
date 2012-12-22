class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string  :username, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
