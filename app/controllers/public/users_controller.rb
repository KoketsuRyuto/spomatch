class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update,:confilm,:withdraw]
  before_action :check_guest_user, only: [:edit,:update,:confilm,:withdraw]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @groups = @user.groups
    @sports = Sport.all
    @tags = Tag.all
    @favorite = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorites = Post.find(@favorite)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(update_params)
      redirect_to user_path(@user), notice: "会員情報を更新しました"
    else
      render :edit
    end
  end

  def confilm
  end

  def withdraw
    current_user.update(is_deleted: true)
    reset_session
    flash[:alert] = '退会しました。'
    redirect_to root_path
  end

  private

  def update_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
