class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :group_users, dependent: :destroy
  has_many :group_chats, dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image(width,height)
    profile_image.variant(resize_to_fill: [width,height]).processed
  end
end
