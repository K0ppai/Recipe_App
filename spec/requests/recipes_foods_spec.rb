require 'rails_helper'

RSpec.describe 'RecipesFoods', type: :request do
  let(:user) { User.create(name: 'koppai', email: 'test@example.com', password: 'password') }
  let(:recipe) { Recipe.create(name: 'food', preparation_time: 20, cooking_time: 10, description: 'this is how', public: false, user:) }

  describe 'GET /recipes/:recipe_id/recipes_foods/new' do
    before :each do
      sign_in user
      get new_recipe_recipes_food_path(recipe_id: recipe)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'should render the correct template' do
      expect(response).to render_template(:new)
    end
  end
end
