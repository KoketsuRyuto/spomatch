# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました。"
  end

  def destroy
    if current_user&.guest?
      # ゲストユーザーの場合はグループチャットのトークを削除して、グループから退会扱いにする
      current_user.groups.each do |group|
        group.group_chats.where(user: current_user).destroy_all
        current_user.group_users.where(group: group).destroy_all
      end
      # ゲストユーザーの場合、他ユーザーの投稿へのコメントを削除する
      current_user.post_comments.destroy_all
      # ゲストユーザー自身の投稿を削除する
      current_user.posts.destroy_all
      # ゲストユーザーの場合、他ユーザーの投稿へのコメントを削除する
      current_user.favorites.destroy_all
    end
    super
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
