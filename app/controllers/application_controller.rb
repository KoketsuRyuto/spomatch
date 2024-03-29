class ApplicationController < ActionController::Base
  
  
  private
  
  def check_guest_user
    if current_user&.guest?
      redirect_to top_path, alert: "ゲストユーザーはこの操作を行うことができません。"
    end
  end
  
end
