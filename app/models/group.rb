class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :group_chats, dependent: :destroy
  has_many :group_sports, dependent: :destroy
  has_many :sports, through: :group_sports
  
  has_one_attached :group_image
  
  def get_group_image(width,height)
    group_image.variant(resize_to_fill: [width,height]).processed
  end
  
end
