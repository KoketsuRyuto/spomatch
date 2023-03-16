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
    @tags = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @sports = Sport.all
    @tags = Tag.all
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    Post.find(params[:id]).update(update_params)
    redirect_to post_path(params[:id])
  end
  
  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title,:body, tag_ids: [])
  end
  
  def update_params
    params.require(:post).permit(:title,:body,)
  end
end
