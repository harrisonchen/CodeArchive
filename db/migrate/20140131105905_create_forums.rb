class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :category

      t.timestamps
    end
  end
end
