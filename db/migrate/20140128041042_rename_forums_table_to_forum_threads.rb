class RenameForumsTableToForumThreads < ActiveRecord::Migration
  def change
  	rename_table :forums, :forumThreads
  end
end
