class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all
  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    @inventory.user = current_user
    if @inventory.save
      redirect_to inventories_path, notice: 'Inventory created successfully.'
    else
      flash.now[:alert] = 'Error creating inventory.'
      puts @inventory.errors.full_messages
      puts "Inventory params: #{inventory_params}"
      render :new
    end
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description)
  end
end
