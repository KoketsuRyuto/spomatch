class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :comment, presence: true, length: {maximum: 30}
  
  def set_date
    created_at.strftime("%Y-%-m-%-d %-H:%M")
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["comment"]
  end
end
