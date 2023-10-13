require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { User.create(name: 'koppai', email: 'test@example.com', password: 'password') }
  let(:recipe) { Recipe.create(name: 'food', preparation_time: 20, cooking_time: 10, description: 'this is how', public: false, user:) }

  describe 'GET /recipes' do
    before :each do
      sign_in user
      get recipes_path
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'should render the correct template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /recipes/:id' do
    before :each do
      sign_in user
      get recipe_path(recipe)
    end
    it 'returns http success' do
      expect(response.status).to be 200
    end

    it 'should render the correct template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /recipes/new' do
    before :each do
      sign_in user
      get new_recipe_path
    end
    
    it 'returns http success' do
      expect(response.status).to be 200
    end
    
    it 'should render the correct template' do
      expect(response).to render_template(:new)
    end
  end
end
