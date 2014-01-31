class Forum < ActiveRecord::Base
	has_many :threadposts, foreign_key: :forum_id, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	validates :category, presence: true, length: { maximum: 50 }
end
