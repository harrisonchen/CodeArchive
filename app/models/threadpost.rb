class Threadpost < ActiveRecord::Base
	belongs_to :forum
	belongs_to :user
	has_many :comments, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :forum_id, presence: true
	validates :topic, presence: true
	validates :title, presence: true, length: { maximum: 50 }
end
