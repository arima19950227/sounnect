class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!, :search

   def index
     @users = @q.result(distinct: true)
   end

   def search
    # params[:q]のqには検索フォームに入力した値が入る/検索の処理をしている
    @q = User.ransack(params[:q])
   end

  def show
    @user = User.find(params[:id])
    @reviews = Review.where(user_id: [@user.id]).page(params[:page]).order(created_at: :desc)

  end

  def edit
   @user = User.find(params[:id])

  end

  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to admin_user_path(@user.id)
    else
      render "edit"
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :phone_number, :is_deleted)
  end

end
