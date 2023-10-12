class PublicRecipesController < ApplicationController
  # load_and_authorize_resource
  def index
    @recipes = Recipe.where(public: true).order(created_at: :desc).includes(%i[user recipe_foods])
  end
end
