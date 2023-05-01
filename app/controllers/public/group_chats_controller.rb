class Public::GroupChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :not_join, only:[:show]

  def show
    @group_chats = @group.group_chats.includes(:user)
    @group_chat = @group.group_chats.new
  end

  def create
    @group_chat = current_user.group_chats.build(group_chat_params)
    @group_chat.group_id = @group.id
    if @group_chat.save
      @group_chats = @group.group_chats.includes(:user)
    else
      render 'error'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_chat_params
    params.require(:group_chat).permit(:content)
  end

  def not_join
    unless current_user.group_users.find_by(group_id: @group.id)
      redirect_to group_path(@group), alert: 'グループに参加していません'
    end
  end
end
