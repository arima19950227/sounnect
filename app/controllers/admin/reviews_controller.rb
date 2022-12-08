class Admin::ReviewsController < ApplicationController

  def index
    @reviews= Review.all
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
     redirect_to review_path(@review)
    else
     render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path

  end

 private

  def review_params
    params.require(:review).permit(:name, :address, :sauna_area, :sauna_temperature, :loryu_type, :aufguss, :water_temperature, :water_area, :chair_count, :price, :body, :sauna_time, :congestion, :sauna_image)
  end

end
