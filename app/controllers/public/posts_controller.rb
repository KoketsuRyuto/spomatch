class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
    @post.errors
  end

  def index
    @posts = Post.all
    @sports = Sport.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title,:body, tag_ids: [])
  end
end
