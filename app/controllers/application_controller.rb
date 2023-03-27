class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  private
  
  def check_guest_user
    if current_user&.guest?
      redirect_to root_path, alert: "ゲストユーザーはこの操作を行うことができません。"
    end
  end
  
end
