class Public::GroupChatsController < ApplicationController
  before_action :set_group

  def show
    @group_chats = @group.group_chats.includes(:user)
    @group_chat = @group.group_chats.new
  end
  
  def create
    @group_chat = @group.group_chats.new(group_chat_params)
    @group_chat.user = current_user
    if @group_chat.save
      redirect_to request.referer
    else
      @group_chats = @group.group_chats.includes(:user)
      render 'show'
    end
  end
  
  private
  
  def set_group
    @group = Group.find(params[:group_id])
  end
  
  def group_chat_params
    params.require(:group_chat).permit(:content)
  end
end
