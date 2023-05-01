class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:show, :destroy]
  
  def index
    @q = Post.includes(:user).ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @post_tags = @post.tags
  end
  
  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "管理者側で投稿を削除しました"
  end
  
  private
  
  def set_post
    @post = Post.find(params[:id])
  end
end