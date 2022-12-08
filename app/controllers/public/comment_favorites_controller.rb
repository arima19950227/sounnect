class Public::CommentFavoritesController < ApplicationController

  def create
    review = Review.find(params[:review_id])
    comment = Comment.find(params[:comment_id])
    @comment_favorite = CommentFavorite.create(user_id: current_user.id, review_id: review.id, comment_id: comment.id)
    redirect_to request.referer
  end

  def destroy
    review = Review.find(params[:review_id])
    comment = Comment.find(params[:comment_id])
    CommentFavorite.find_by(user_id: current_user.id, review_id: review.id, comment_id: comment.id).destroy
    redirect_to request.referer
  end

end
