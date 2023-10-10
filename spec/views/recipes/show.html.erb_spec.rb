require 'rails_helper'

RSpec.describe 'recipes/index.html.erb', type: :feature do
  let(:user) { User.create(name: 'koppai') }

  describe 'Testing integration specs for recipes show page' do
    before :each do
      @recipe = Recipe.create(name: 'food', preparation_time: 20, cooking_time: 10, description: 'this is how', public: false, user:)
      food = Food.create(name: 'rice', measurement_unit: 'g', price: 20)
      @recipe_food = RecipeFood.create(recipe: @recipe, food:, quantity: 12)
      @quantity = @recipe_food.quantity
      @price = @recipe_food.food.price
      visit recipe_path(@recipe)
    end

    context 'When visiting to recipes show page' do
      it 'can see the preparation_time' do
        expect(page).to have_content("Preparation time: #{@recipe.preparation_time} hour")
      end

      it 'can see the cooking time' do
        expect(page).to have_content("Cooking time: #{@recipe.cooking_time} hour")
      end

      it 'can see the table headers' do
        expect(page).to have_content('Food')
        expect(page).to have_content('Quantity')
        expect(page).to have_content('Value')
        expect(page).to have_content('Actions')
      end

      it 'can see the name of the recipe food' do
        expect(page).to have_content(@recipe_food.food.name)
      end

      it 'can see the quantity of the recipe food' do
        expect(page).to have_content(@quantity.to_s)
      end

      it 'can see the total value of the recipe food' do
        expect(page).to have_content(@recipe_food.calculated_total_value(@quantity, @price).to_s)
      end
    end

    context 'When opening a modal' do
      it 'can see the generate button' do
        click_on('Generate shopping list')
        expect(page).to have_link('Generate')
      end
    end
  end
end
