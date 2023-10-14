class Food < ApplicationRecord
  has_many :inventory_foods, foreign_key: 'food_id'
  has_many :recipe_foods, foreign_key: 'food_id'

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true
end
