class AddTitleToThreadpost < ActiveRecord::Migration
  def change
  	add_column :threadposts, :title, :string
  end
end
