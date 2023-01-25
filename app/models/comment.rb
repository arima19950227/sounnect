class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  # has_many :comment_favorites, dependent: :destroy


  def comment_favorited_by?(user)
    comment_favorites.exists?(user_id: user.id)
  end
end
