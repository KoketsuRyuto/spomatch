class Sport < ApplicationRecord
  has_many :group_sports, dependent: :destroy
end
