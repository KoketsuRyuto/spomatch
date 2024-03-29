class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @tag = Tag.new
    @tags = Tag.all
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path
    else
      @tags = Tag.all
      render "admin/tags/index"
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end
  
  def update
    @tag = Tag.find(params[:id])
    if @tag.update(update_params)
      redirect_to admin_tags_path
    else
      render "admin/tags/edit"
    end
  end
  
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
  end
  
  private
  
  def tag_params
    params.require(:tag).permit(:name)
  end
  
  def update_params
    params.require(:tag).permit(:name)
  end
  
end
