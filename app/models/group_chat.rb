class GroupChat < ApplicationRecord
  belongs_to :user
  belongs_to :group
  
  validates :content, presence: true, length: {maximum: 50 }
end
