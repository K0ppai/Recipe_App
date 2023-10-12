require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { User.create(name: 'koppai', email: 'test@example.com', password: 'password') }
  let(:recipe) { Recipe.create(name: 'food', preparation_time: 20, cooking_time: 10, description: 'this is how', public: false, user:) }

  describe 'GET /recipes' do
    before :each do
      sign_in user
    end
    it 'returns http success' do
      get recipes_path
      expect(response).to have_http_status(:success)
    end

    it 'should render the correct template' do
      get recipes_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /recipes/:id' do
    before :each do
      sign_in user
    end
    it 'returns http success' do
      get recipe_path(recipe)
      expect(response.status).to be 200
    end

    it 'should render the correct template' do
      get recipe_path(recipe)
      expect(response).to render_template(:show)
    end
  end
end
