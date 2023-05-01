class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    post = Post.find(params[:post_id])
    @comment = post.post_comments.new(post_comment_params)
    @comment.user_id = current_user.id
    unless @comment.save
      render "error"
    end
  end
  
  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
