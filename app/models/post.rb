class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  
  has_one_attached :post_image
  
  validates :title, presence: true, length: {maximum: 30}
  validates :body, presence: true, length: {maximum: 200}
  
  
  def set_date
    created_at.strftime("%Y/%-m/%-d/ %-H:%M")
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  #ユーザーステータスが有効の投稿のみ表示
  def self.get_active_posts
    self.joins(:user).where(users: { is_deleted: false }).order(created_at: :desc)
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["title","body"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["favorites", "post_comments", "post_image_attachment", "post_image_blob", "post_tags", "tags", "user"]
  end
end
