class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  
  has_one_attached :post_image
  
  def set_date
    created_at.strftime("%Y/%-m/%-d/ %-H:%M")
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
