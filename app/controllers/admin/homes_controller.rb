class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @reviews= Review.all
  end

  private
  def review_params
    params.require(:review).permit(:name, :address, :sauna_area, :sauna_temperature, :loryu_type, :aufguss, :water_temperature, :water_area, :chair_count, :price, :body, :sauna_time, :congestion, :sauna_image)
  end


end
