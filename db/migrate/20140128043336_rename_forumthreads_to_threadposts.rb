class RenameForumthreadsToThreadposts < ActiveRecord::Migration
  def change
  	rename_table :forumthreads, :threadposts
  end
end
