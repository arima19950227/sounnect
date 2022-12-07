class Public::CommentsController < ApplicationController

 def create
   @review = Review.find(params[:review_id])
   comment = current_user.comments.new(comment_params)
   comment.review_id = @review.id
   comment.save
   redirect_to request.referer
 end

 def destroy
  @review = Review.find(params[:review_id])
  Comment.find(params[:id]).destroy
  redirect_to request.referer
 end

private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
