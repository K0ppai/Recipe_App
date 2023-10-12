require 'rails_helper'

RSpec.describe 'recipes/index.html.erb', type: :feature do
  let(:user) { User.create(name: 'koppai', email: 'test@example.com', password: 'password') }

  describe 'Testing integration specs for recipes index page' do
    before :each do
      Recipe.create(name: 'food', preparation_time: 20, cooking_time: 10, description: 'this is how', public: false, user:)
      login_as(user, scope: :user)
      visit recipes_path
    end

    context 'When visiting to recipes' do
      it 'can see the name of the recipe' do
        expect(page).to have_content('food')
      end
    end

    context 'When clicking on new recipe button' do
      it 'can see the name of the recipe' do
        click_on 'Make a new recipe'
        expect(current_path).to eq(new_recipe_path)
      end
    end
  end
end
