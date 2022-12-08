class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
   def index
    @users = User.all
   end

  def show
    @user = User.find(params[:id])
    @reviews = Review.all
  end

  def edit
   @user = User.find(params[:id])

  end

  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
    else
      render "edit"
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :phone_number, :is_deleted)
  end

end
