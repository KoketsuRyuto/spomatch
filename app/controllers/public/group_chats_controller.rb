class Public::GroupChatsController < ApplicationController
  def show
    @group = Group.find(params[:group_id])
    @group_chat = GroupChat.new
    @group_chats = GroupChat.all 
  end
  
  def create
    @group_chat = current_user.group_chat.new(group_chat_params)
    @group_chat.save
    redirect_to group_group_chat_path(@group, @group_chat)
  end
  
  private
  
  def method_name
    params.require(:group_chat).permit(:content)
  end
end
