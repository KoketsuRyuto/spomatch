class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end
end
