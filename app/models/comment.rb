class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_many :comment_favorites, dependent: :destroy
end
