class CreateThreadposts < ActiveRecord::Migration
  def change
    create_table :threadposts do |t|
      t.string :topic
      t.integer :user_id

      t.timestamps
    end
    add_index :threadposts, [:user_id, :created_at]
  end
end