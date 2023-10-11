class RecipeFood < ApplicationRecord
  belongs_to :recipe, class_name: 'Recipe', foreign_key: 'recipe_id'
  belongs_to :food, class_name: 'Food', foreign_key: 'food_id'
  accepts_nested_attributes_for :food

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_save :set_total_value

  after_save :update_totalvaluecounter, :update_foodcounter

  private

  def update_foodcounter
    recipe.increment!(:foodcounter)
  end

  def update_totalvaluecounter
    total_count = recipe.totalvaluecounter + totalvalue
    recipe.update(totalvaluecounter: total_count)
  end

  def set_total_value
    self.totalvalue = quantity * food.price
  end
end
