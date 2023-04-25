class Sport < ApplicationRecord
  has_many :group_sports, dependent: :destroy
  has_many :groups, through: :group_sports
  
  validates :name, presence: true, uniqueness: true
end
