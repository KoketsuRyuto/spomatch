class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :comment, presence: true, length: {maximum: 30}
  
  def self.get_active_comments
    # ユーザーステータスが有効のコメントのみ表示
    self.joins(:user).where(users: { is_deleted: false })
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["comment"]
  end
end
