class CreateGroupSports < ActiveRecord::Migration[6.1]
  def change
    create_table :group_sports do |t|
      t.references :sport, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
