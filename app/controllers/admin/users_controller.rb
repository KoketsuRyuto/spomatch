class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @posts = @user.posts.page(params[:page]).per(4)
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to admin_path
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:is_deleted)
  end

end
