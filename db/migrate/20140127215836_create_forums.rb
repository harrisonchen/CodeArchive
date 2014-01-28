class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :topic
      t.integer :user_id

      t.timestamps
    end
    add_index :forums, [:user_id, :created_at]
  end
end
