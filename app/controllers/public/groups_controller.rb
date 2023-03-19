class Public::GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    if @group.update(update_params)
      redirect_to groups_path
    else
      render 'edit'
    end
  end
  
  def destroy
    Group.find(params[:id]).destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name,:introduction,:owner_id,sport_ids: [])
  end
  
  def update_params
    params.require(:group).permit(:name,:introduction,sport_ids: [])
  end
  
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end