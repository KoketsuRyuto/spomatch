class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "管理者側で投稿を削除しました"
  end
end