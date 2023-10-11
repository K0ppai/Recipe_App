class RecipeFood < ApplicationRecord
  belongs_to :recipe, class_name: "Recipe", foreign_key: "recipe_id"
  belongs_to :food, class_name: "Food", foreign_key: "food_id"
  accepts_nested_attributes_for :food
  
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def calculated_total_value(quantity, price)
    quantity * price
  end
end
