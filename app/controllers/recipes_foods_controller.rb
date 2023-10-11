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
      redirect_to recipe_path(@recipe), notice: 'RecipeFood was successfully created.'
    else
      render :new, alert: "Something went wrong"
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])

    amount = @recipe.totalvaluecounter - @recipe_food.totalvalue
    @recipe.update(totalvaluecounter: amount)

    @recipe.decrement!(:foodcounter)

    @recipe_food.destroy
    redirect_to recipe_path(id: @recipe), notice: 'RecipeFood deleted successfully!'
  end
  
  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id, food_attributes: [:name, :measurement_unit, :price])
  end
end
