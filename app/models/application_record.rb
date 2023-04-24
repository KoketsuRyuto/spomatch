class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def set_date
    created_at.strftime("%Y-%-m-%-d %-H:%M")
  end
end
