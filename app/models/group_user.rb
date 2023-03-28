class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
  
  def guest?
    user.guest?
  end
end
