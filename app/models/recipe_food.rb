class RecipeFood < ApplicationRecord
  belongs_to :recipe, class_name: "Recipe", foreign_key: "recipe_id"
  belongs_to :food, class_name: "Food", foreign_key: "food_id"
  accepts_nested_attributes_for :food
  
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_totalvaluecounter

  def calculated_total_value(quantity, price)
    quantity * price
  end

  private

  def update_totalvaluecounter
    total_value = recipe.totalvaluecounter + calculated_total_value(quantity, food.price)
    recipe.update(totalvaluecounter: total_value)
  end
end
