class Public::UsersController < ApplicationController

  before_action :search

  def index
    # distinct: trueは重複したデータを除外/検索結果の表示
    @users = @q.result(distinct: true)
  end

  def search
    # params[:q]のqには検索フォームに入力した値が入る/検索の処理をしている
    @q = User.ransack(params[:q])
  end

  def show
    #レコードからユーザー1人1人の情報を持ってくる
    @user = User.find(params[:id])
    #roomがcreateされた時に、現在ログインしているユーザーと、
    #「チャットへ」を押されたユーザーの両方をEntriesテーブルに記録する必要があるので、
    #whereメソッドでそのユーザーを探している
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)

    #showページのユーザーが現在ログインしているユーザーではないというunlessの条件
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
      @userEntry.each do |u|
      #roomsが作成されている場合と作成されていない場合に条件分岐
        if cu.room_id == u.room_id then
          @isRoom = true
          @roomId = cu.room_id
        end
      end
     end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end

  if @user.id == current_user.id
    user_ids = current_user.following_ids # フォローしているユーザーのid一覧
    user_ids.push(current_user.id)  # 自身のidを一覧に追加する
    @reviews = Review.where(user_id: user_ids).page(params[:page]).order(created_at: :desc)
  else
     @reviews = Review.where(user_id: [@user.id]).page(params[:page]).order(created_at: :desc)
  end

  end

  def edit
   @user = User.find(params[:id])

  end

  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報更新"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def unsubscribe
     @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
