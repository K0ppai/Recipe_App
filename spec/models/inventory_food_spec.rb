require 'rails_helper'

RSpec.describe InventoryFood, type: :model do
  let(:inventory) { Inventory.create(name: 'Sample Inventory') }
  let(:food) { Food.create(name: 'Sample Food') }

  it 'is valid with valid attributes' do
    inventory_food = InventoryFood.new(
      inventory:,
      food:,
      quantity: 10
    )
    expect(inventory_food).to be_valid
  end

  it 'is not valid without a quantity' do
    inventory_food = InventoryFood.new(
      inventory:,
      food:
    )
    expect(inventory_food).not_to be_valid
  end

  it 'is not valid if quantity is not a positive integer' do
    inventory_food = InventoryFood.new(
      inventory:,
      food:,
      quantity: -5
    )
    expect(inventory_food).not_to be_valid

    inventory_food.quantity = 5.5
    expect(inventory_food).not_to be_valid
  end
end
