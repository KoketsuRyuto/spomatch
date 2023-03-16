class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :group_chats, dependent: :destroy
  has_one_attached :group_image
end
