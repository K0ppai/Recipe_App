require 'rails_helper'

RSpec.describe "recipes/index.html.erb", type: :feature do
  let(:user) { User.create(name: "koppai") }
  
  describe "Testing integration specs for recipes show page" do
    before :each do
      @recipe = Recipe.create(name: "food", preparation_time: 20, cooking_time: 10, description: "this is how", public: false, user: ) 
      visit recipe_path(@recipe)
    end

    context "When visiting to recipes show page" do
      it "can see the preparation_time" do
        expect(page).to have_content("Preparation time: #{@recipe.preparation_time} hour")
      end
      
      it "can see the cooking time" do
        expect(page).to have_content("Cooking time: #{@recipe.cooking_time} hour")
      end
    end
  end
end
