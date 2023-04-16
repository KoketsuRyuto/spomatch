class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  def set_date
    created_at.strftime("%Y-%-m-%-d %-H:%M")
  end
end
