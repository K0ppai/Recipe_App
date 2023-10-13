require 'rails_helper'

RSpec.describe 'recipes/show.html.erb', type: :feature do
  let(:user) { User.create(name: 'koppai', email: 'test@example.com', password: 'password') }

  describe 'Testing integration specs for recipes show page' do
    before :each do
      @inventory = Inventory.create(user:, name: 'Home', description: 'Home Remedies')
      @recipe = Recipe.create(name: 'food', preparation_time: 20, cooking_time: 10, description: 'this is how', public: false, user:)
      food = Food.create(name: 'rice', measurement_unit: 'g', price: 20)
      @inventory_food = InventoryFood.create(quantity: 2, inventory: @inventory, food:)
      @recipe_food = RecipeFood.create(recipe: @recipe, food:, quantity: 12)
      @quantity = @recipe_food.quantity
      @price = @recipe_food.food.price
      login_as(user, scope: :user)
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
        expect(page).to have_content(@recipe_food.totalvalue)
      end
    end

    context 'When opening a modal' do
      before :each do
        click_on('Generate shopping list')
      end

      it 'can see the generate button' do
        expect(page).to have_content('Generate')
        expect(page).to have_content('Generating Shopping List')
      end

      it 'should lead to shopping list path after choosing in inventory' do
        select 'Home', from: 'inventory_id'
        click_button 'Generate'
        expect(page).to have_text('10 g')
        expect(current_path).to eq(shopping_list_path)
      end
    end

    context 'When clicking add ingredient btn' do
      it 'should visit new_recipe_recipes_food_path' do
        click_on 'Add ingredient'
        expect(current_path).to eq new_recipe_recipes_food_path(recipe_id: @recipe)
      end
    end

    context 'When clicking remove button for ingredient' do
      it 'should remove the ingredient' do
        click_on 'Remove'
        expect(page).not_to have_content(@recipe_food.food.name)
      end
    end
  end
end
