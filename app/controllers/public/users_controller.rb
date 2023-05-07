class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:edit, :update,:confilm,:withdraw]
  before_action :check_guest_user, only: [:edit,:update,:confilm,:withdraw]

  def show
    @user = User.includes(:posts, :groups, :favorites).find(params[:id])
    @posts = @user.posts.latest
    @groups = @user.groups
    @favorites = Post.joins(:favorites).where(favorites: { user_id: @user.id }).includes(:user).latest
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

  def authorize_user
    user = User.find(params[:id])
    unless user == current_user
      redirect_to user_path(current_user)
    end
  end
end
