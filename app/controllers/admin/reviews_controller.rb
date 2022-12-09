class Admin::ReviewsController < ApplicationController

 before_action :authenticate_admin!, :search

  def index
    @reviews = @q.result(distinct: true)
  end

  def search
    # params[:q]のqには検索フォームに入力した値が入る/検索の処理をしている
    @q = Review.ransack(params[:q])
  end

  def show
    @review = Review.find(params[:id])

  end

  def edit
    @review = Review.find(params[:id])

  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
    flash[:notice] = "レビューを更新しました"
     redirect_to admin_review_path(@review)
    else
     render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to reviews_path

  end

 private

  def review_params
    params.require(:review).permit(:name, :address, :sauna_area, :sauna_temperature, :loryu_type, :aufguss, :water_temperature, :water_area, :chair_count, :price, :body, :sauna_time, :congestion, :sauna_image)
  end

end
