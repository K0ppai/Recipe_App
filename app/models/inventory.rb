class Inventory < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :inventory_foods

  validates :name, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true
end
