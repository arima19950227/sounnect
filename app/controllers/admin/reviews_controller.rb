class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @params = params
    if params[:address]
      if params[:price_min] == "" || params[:price_max] == ""
        @reviews = Review.where(["name LIKE(?) and address LIKE(?) and sauna_area  LIKE(?) and sauna_temperature LIKE(?) and loryu_type LIKE(?) and aufguss LIKE(?) and water_area LIKE(?) and water_temperature LIKE(?)", "%#{params[:name]}%", "%#{params[:address]}%", "%#{params[:sauna_area]}%", "%#{params[:sauna_temperature]}%", "%#{params[:loryu_type]}%", "%#{params[:aufguss]}%", "%#{params[:water_area]}%", "%#{params[:water_temperature]}%"]).page(params[:page]).order(created_at: :desc)

      else
        @reviews = Review.where(["name LIKE(?) and address LIKE(?) and sauna_area  LIKE(?) and sauna_temperature LIKE(?) and loryu_type LIKE(?) and aufguss LIKE(?) and water_area LIKE(?) and water_temperature LIKE(?)", "%#{params[:name]}%", "%#{params[:address]}%", "%#{params[:sauna_area]}%", "%#{params[:sauna_temperature]}%", "%#{params[:loryu_type]}%", "%#{params[:aufguss]}%", "%#{params[:water_area]}%", "%#{params[:water_temperature]}%"])
        .where(price: (params[:price_min])..(params[:price_max])).page(params[:page]).order(created_at: :desc)
      end
    else
      @reviews = Review.page(params[:page]).order(created_at: :desc)
    end
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
    redirect_to admin_reviews_path
  end

 private
   def review_params
     params.require(:review).permit(:name, :address, :sauna_area, :sauna_temperature, :loryu_type, :aufguss, :water_temperature, :water_area, :chair_count, :price, :body, :sauna_time, :congestion, :sauna_image)
   end
end
