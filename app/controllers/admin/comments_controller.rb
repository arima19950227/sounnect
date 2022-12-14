class Admin::CommentsController < ApplicationController

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
