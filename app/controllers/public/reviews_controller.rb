class Public::ReviewsController < ApplicationController
  def index
    # distinct: trueは重複したデータを除外/検索結果の表示
    @params = params
    if params[:latest]
      @reviews = Review.latest.page(params[:page])
    elsif params[:star_count]
      @reviews = Review.star_count.page(params[:page])
    else
     if params[:address]
        if params[:price_min] == "" ||  params[:price_max] == ""
          @reviews = Review.where(['name LIKE(?) and address LIKE(?) and sauna_area  LIKE(?) and sauna_temperature LIKE(?) and loryu_type LIKE(?) and aufguss LIKE(?) and water_area LIKE(?) and water_temperature LIKE(?)', "%#{params[:name]}%", "%#{params[:address]}%" , "%#{params[:sauna_area]}%", "%#{params[:sauna_temperature]}%", "%#{params[:loryu_type]}%", "%#{params[:aufguss]}%", "%#{params[:water_area]}%", "%#{params[:water_temperature]}%"])
          .page(params[:page]).order(created_at: :desc)
        else
          @reviews  = Review.where(['name LIKE(?) and address LIKE(?) and sauna_area  LIKE(?) and sauna_temperature LIKE(?) and loryu_type LIKE(?) and aufguss LIKE(?) and water_area LIKE(?) and water_temperature LIKE(?)', "%#{params[:name]}%", "%#{params[:address]}%" , "%#{params[:sauna_area]}%", "%#{params[:sauna_temperature]}%", "%#{params[:loryu_type]}%", "%#{params[:aufguss]}%", "%#{params[:water_area]}%", "%#{params[:water_temperature]}%"])
          .where(price: (params[:price_min])..(params[:price_max])).page(params[:page]).order(created_at: :desc)
        end
     else
        @reviews =  Review.page(params[:page]).order(created_at: :desc)
     end
    end
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
    unless ViewCount.find_by(user_id: current_user.id, review_id: @review.id)
      current_user.view_counts.create(review_id: @review.id)
    end
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
    params.require(:review).permit(:name, :address, :sauna_area, :sauna_temperature, :loryu_type, :aufguss, :water_temperature, :water_area, :chair_count, :price, :body, :sauna_time, :congestion, :sauna_image, :evaluation, :latitude, :longitude)
  end

end
