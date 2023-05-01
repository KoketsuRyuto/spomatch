class Public::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search_sport]
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner, only: [:edit, :update]

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
    # パラメータから検索されたスポーツジャンルを取得する
    @sport = Sport.find(params[:sport_id])
    # 全てのスポーツジャンルを取得する（ビューでリストとして表示するため）
    @sports = Sport.all
    # 検索されたスポーツジャンルに関連するグループを取得する（N+1問題を避けるために、includesを使用する）
    @groups = @sport.groups.includes(:users).page(params[:page]).per(10)
  end

  def show
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
  end

  def update
    if @group.update(update_params)
      redirect_to group_path(@group), notice: "グループ情報を更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: "グループを削除しました"
  end

  private
  
  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name,:introduction,:group_image,:owner_id,sport_ids: [])
  end

  def update_params
    params.require(:group).permit(:name,:introduction,:group_image,sport_ids: [])
  end

  def authorize_owner
    group = Group.find(params[:id])
    unless group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end