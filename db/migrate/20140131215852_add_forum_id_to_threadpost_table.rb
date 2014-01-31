class AddForumIdToThreadpostTable < ActiveRecord::Migration
  def change
  	add_column :threadposts, :forum_id, :integer
  end
end
