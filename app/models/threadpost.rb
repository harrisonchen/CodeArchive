class Threadpost < ActiveRecord::Base
	belongs_to :user
	has_many :comments, foreign_key: :threadpost_id, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :topic, presence: true, length: { maximum: 50 }
end
