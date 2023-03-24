class Admin::PostCommentsController < ApplicationController
  def index
    @q = PostComment.ransack(params[:q])
    @post_comments = @q.result(distinct: true)
  end

  def show
    @post_comment = PostComment.find(params[:id])
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to request.referer
  end
end
