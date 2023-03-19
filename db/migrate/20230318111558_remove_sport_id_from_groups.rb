class RemoveSportIdFromGroups < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :sport_id, :integer
  end
end
