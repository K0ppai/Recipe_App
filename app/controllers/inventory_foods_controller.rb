class InventoryFoodsController < ApplicationController
  before_action :set_inventory

  def new
    @inventory_food = InventoryFood.new
  end

  def create
    @inventory_food = @inventory.inventory_foods.build(inventory_food_params)
    if @inventory_food.save
      redirect_to inventory_path(@inventory), notice: 'Food added successfully.'
    else
      render :new
    end
  end

  def destroy
    @inventory_food = @inventory.inventory_foods.find_by(food_id: params[:inventory_food][:food_id])
    if @inventory_food
      @inventory_food.destroy
      redirect_to inventory_path(@inventory), notice: 'Food removed successfully.'
    else
      redirect_to inventory_path(@inventory), alert: 'Food not found in inventory.'
    end
  end

  private

  def set_inventory
    @inventory = Inventory.find(params[:inventory_id])
  end

  def inventory_food_params
    params.require(:inventory_food).permit(:food_id, :quantity)
  end
end
