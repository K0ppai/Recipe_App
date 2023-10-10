require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before :each do
    @user = User.new(name: 'TestUser')
    @recipe = Recipe.new(name: 'food', preparation_time: 20, cooking_time: 10, description: 'this is how', public: false, user: @user)
  end

  context "When creating a new recipe" do
    it "name should not be blank" do
      @recipe.name = nil
      expect(@recipe).not_to be_valid
    end
    
    it "name length should be between 1 and 100" do
      @recipe.name = 'a' * 120
      expect(@recipe).not_to be_valid
    end

    it "preparation_time should not be blank" do
      @recipe.preparation_time = nil
      expect(@recipe).not_to be_valid
    end

    it "cooking_time should not be blank" do
      @recipe.cooking_time = nil
      expect(@recipe).not_to be_valid
    end

    it "description should not be blank" do
      @recipe.description = nil
      expect(@recipe).not_to be_valid
    end

    it "public should not be blank" do
      @recipe.public = nil
      expect(@recipe).not_to be_valid
    end
  end
end
