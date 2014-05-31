class Comment < ActiveRecord::Base

  validates :comment, presence: true
  validates :username, presence: true

  scope :filterByPost, -> (postId) { where(post_id: postId)}

	belongs_to :post
end
