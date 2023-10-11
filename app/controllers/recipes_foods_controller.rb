class RecipesFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
    @recipe_food.build_food
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe = @recipe

    if @recipe_food.save
      redirect_to recipe_path(@recipe)
    else
      render :new, alert: "Something went wrong"
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, food_attributes: [:name, :measurement_unit, :price])
  end
end
