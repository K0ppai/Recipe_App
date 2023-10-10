require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before :each do
    user = User.new(name: 'koppai')
    recipe = Recipe.new(name: 'food', preparation_time: 20, cooking_time: 10, description: 'this is how', public: false, user:)
    food = Food.new(name: 'rice', measurement_unit: 'g', price: 20)
    @recipe_food = RecipeFood.new(recipe:, food:, quantity: 12)
  end

  context 'When creating a new recipe_food' do
    it 'quantity should not be blank' do
      @recipe_food.quantity = nil
      expect(@recipe_food).not_to be_valid
    end

    it 'quantity should not be negative' do
      @recipe_food.quantity = -12
      expect(@recipe_food).not_to be_valid
    end

    it 'without belongs_to associations, it should be invalid' do
      @recipe_food.food = nil
      expect(@recipe_food).not_to be_valid
    end
  end
end
