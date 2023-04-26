class Public::HomesController < ApplicationController
  def top
    @sports = Sport.all
    @posts = Post.order(created_at: :desc).limit(3)
    @groups = Group.order(created_at: :desc).limit(3)
    @tags = Tag.all
  end

  def about
  end
end
