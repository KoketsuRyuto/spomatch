class Public::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search_sport]
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to groups_path, notice: "グループの作成に成功しました"
    else
      render 'new'
    end
  end

  def index
    @groups = Group.page(params[:page]).per(10)
    @sports = Sport.all
  end
  # 検索されたスポーツジャンルの一覧を表示するページ
  def search_sport
    @group_sports = Sport.page(params[:page]).per(10)
    @sport = Sport.find(params[:sport_id])
    @groups = @sport.groups.all
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to group_path(@group), notice: "グループに参加しました"
  end

  def withdraw
    @group = Group.find(params[:group_id])
    @group.users.delete(current_user)
    redirect_to groups_path, notice: "グループを退会しました"
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(update_params)
      redirect_to group_path(@group), notice: "グループ情報を更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to groups_path, notice: "グループを削除しました"
  end

  private

  def group_params
    params.require(:group).permit(:name,:introduction,:group_image,:owner_id,sport_ids: [])
  end

  def update_params
    params.require(:group).permit(:name,:introduction,:group_image,sport_ids: [])
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end