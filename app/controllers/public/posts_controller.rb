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
      render 'new'
    end
    @post.errors
  end

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)

    @tags = Tag.all
    @sports = Sport.all
  end
  
  def search_tag
    @post_tags = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @sports = Sport.all
    @tags = Tag.all
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if Post.find(params[:id]).update(update_params)
      redirect_to post_path(params[:id])
    else
      render 'edit'
    end
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
