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

    inventory_quantity_by_food_id = @inventory_foods.group_by(&:food_id).transform_values { |ifs| ifs.sum(&:quantity) }
    recipe_quantity_by_food_id = @recipe_foods.group_by(&:food_id).transform_values { |rfs| rfs.sum(&:quantity) }
    puts "This is the inventory_foods #{inventory_quantity_by_food_id}"
    puts "This is recipe_foods #{recipe_quantity_by_food_id}"

    food_prices_by_food_id = @recipe_foods.group_by(&:food_id).transform_values { |rfs| rfs.first.food.price }
    puts "This is foodprice hash #{food_prices_by_food_id}"

    food_ids = (inventory_quantity_by_food_id.keys + recipe_quantity_by_food_id.keys).uniq
    puts "This is after combing the foodid keys #{food_ids}"

    difference_by_food_id = Hash.new { |hash, key| hash[key] = { quantity: 0, price: 0 } }

    food_ids.each do |food_id|
      inventory_quantity = inventory_quantity_by_food_id[food_id].to_i
      recipe_quantity = recipe_quantity_by_food_id[food_id].to_i
      food_price = food_prices_by_food_id[food_id].to_i
      difference = recipe_quantity - inventory_quantity

      if difference.positive?
        difference_by_food_id[food_id][:quantity] = difference
        difference_by_food_id[food_id][:price] = food_price * difference_by_food_id[food_id][:quantity]
      end
    end
    puts "this is final result #{difference_by_food_id}"

    totalprice = difference_by_food_id.values.sum { |value| value[:price] }
    puts "This is the total price #{totalprice}"
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

  def new_food; end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
