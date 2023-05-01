class Public::HomesController < ApplicationController
  def top
    @sports = Sport.all
    @posts = Post.includes(:user, :tags).order(created_at: :desc).limit(3)
    @groups = Group.includes(:users, :group_sports).order(created_at: :desc).limit(3)
    @tags = Tag.all
  end

  def about
  end
end
