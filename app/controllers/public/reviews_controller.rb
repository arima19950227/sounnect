class Public::ReviewsController < ApplicationController

  before_action :search

  def index
    # distinct: trueは重複したデータを除外/検索結果の表示
    @reviews=  @q.result(distinct: true)
  end

   def search
    # params[:q]のqには検索フォームに入力した値が入る/検索の処理をしている
    @q = Review.ransack(params[:q])
   end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
     if @review.save
       flash[:notice] = "投稿に成功しました"
       redirect_to review_path(@review.id)
     else
      render :new
     end
  end

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new

  end

  def edit
    @review = Review.find(params[:id])
    if @review.user == current_user
      render :edit
    else
      redirect_to reviews_path
    end
  end

  def update
    @review = Review.find(params[:id])
    @review.user_id = current_user.id
    if @review.update(review_params)
     flash[:notice] = "レビューを更新しました"
     redirect_to review_path(@review)
    else
     render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.user_id = current_user.id
    @review.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to reviews_path

  end



 private

  def review_params
    params.require(:review).permit(:name, :address, :sauna_area, :sauna_temperature, :loryu_type, :aufguss, :water_temperature, :water_area, :chair_count, :price, :body, :sauna_time, :congestion, :sauna_image)
  end

end
