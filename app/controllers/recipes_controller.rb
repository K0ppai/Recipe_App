class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  def shopping_list
    @inventory = Inventory.find(params[:inventory_id])
    @recipe = Recipe.find(params[:recipe_id])
    @inventory_foods = @inventory.inventory_foods.includes(:food)
    @recipe_foods = @recipe.recipe_foods.includes(:food)

    inventory_quantities = @inventory_foods.group_by(&:food_id).transform_values { |ifs| ifs.sum(&:quantity) }
    recipes = @recipe_foods.group_by(&:food_id).transform_values do |rf|
      {
        quantity: rf.sum(&:quantity),
        name: rf.first.food.name,
        price: rf.first.food.price,
        measurement_unit: rf.first.food.measurement_unit
      }
    end

    @shopping_lists = []

    recipes.keys.each do |food_id|
      inventory_quantity = inventory_quantities.keys.include?(food_id) ? inventory_quantities[food_id] : 0
      recipe_quantity = recipes[food_id][:quantity]
      food_price = recipes[food_id][:price]
      food_name = recipes[food_id][:name]
      food_unit = recipes[food_id][:measurement_unit]
      difference = recipe_quantity - inventory_quantity
      calculated_price = food_price * difference

      next unless difference.positive?

      hash = {
        name: food_name,
        quantity: difference,
        price: calculated_price,
        unit: food_unit
      }
      @shopping_lists << hash
    end

    @totalprice = @shopping_lists.sum { |value| value[:price] }
  end

  def modal; end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.recipe_foods.destroy_all
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe deleted successfully!'
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(id: @recipe), notice: 'Recipe is now public.'
    else
      redirect_to recipe_path(id: @recipe), alert: 'Something went wrong'
    end
  end

  def new_food; end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
