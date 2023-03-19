class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :group_chats, dependent: :destroy
  has_many :group_sports, dependent: :destroy
  has_many :sports, through: :group_sports
  has_one_attached :group_image
  
  def get_group_image(width,height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      group_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    else
      group_image.variant(resize_to_fill: [width,height]).processed
    end
  end
  
end
