class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:search_tag]
  before_action :ensure_correct_post, only: [:edit,:update,:destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿に成功しました"
    else
      render :new
    end
  end

  def index
    # get_active_postsメソッドを使って退会済みのユーザーの投稿は非表示に
    @q = Post.ransack(params[:q])
    if params[:latest]
      @posts = @q.result(distinct: true).get_active_posts.latest.page(params[:page]).per(10)
    elsif params[:old]
      @posts = @q.result(distinct: true).get_active_posts.old.page(params[:page]).per(10)
    else
      @posts = @q.result(distinct: true).get_active_posts.page(params[:page]).per(10)
    end

    @tags = Tag.all
    @sports = Sport.all
  end

  # 投稿タグの検索結果を表示するページ
  def search_tag
    @post_tags = Tag.page(params[:page]).per(10)
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = PostComment.new
    @sports = Sport.all
    @tags = Tag.all
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(update_params)
      redirect_to post_path(@post), notice: "投稿をしました"
    else
      render :edit
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:title,:body, tag_ids: [])
  end

  def update_params
    params.require(:post).permit(:title,:body, tag_ids: [])
  end
  
  def ensure_correct_post
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end
end
