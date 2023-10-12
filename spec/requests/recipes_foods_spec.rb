require 'rails_helper'

RSpec.describe 'RecipesFoods', type: :request do
  let(:user) { User.create(name: 'koppai', email: 'test@example.com', password: 'password') }
  let(:recipe) { Recipe.create(name: 'food', preparation_time: 20, cooking_time: 10, description: 'this is how', public: false, user:) }

  describe 'GET /new' do
    before :each do
      sign_in user
    end

    it 'returns http success' do
      get recipe_path(recipe)
      expect(response).to have_http_status(:success)
    end
  end
end
