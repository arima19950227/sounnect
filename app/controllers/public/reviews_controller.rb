class Public::ReviewsController < ApplicationController

  def index
  end

  def new
    @review = Review.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

 private

  def review_params
    params.require(:review).permit(:name, :address, :sauna_area, :sauna_temperature, :loryu_type, :aufguss, :water_temperature, :water_area, :chair_count, :price, :body, :sauna_time, :congestion)
  end

end
