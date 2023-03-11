class Public::UsersController < ApplicationController
  
  def confilm
  end
  def show
    @user = current_user
    @posts = current_user.posts
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

  
  private
  
  def update_params
    params.require(:user).permit(:name,:profile_image)
  end
end
