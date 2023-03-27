class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @q = PostComment.ransack(params[:q])
    @post_comments = @q.result(distinct: true).page(params[:page]).per(10)
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
