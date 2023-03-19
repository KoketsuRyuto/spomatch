class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @sports = Sport.all
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.update(update_params)
    redirect_to user_path(@user)
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
    params.require(:user).permit(:name,:profile_image)
  end
end
