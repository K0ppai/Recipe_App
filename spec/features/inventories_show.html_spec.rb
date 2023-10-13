require 'rails_helper'

RSpec.feature 'Show Inventory Page' do
  scenario 'User visits the Show Inventory page' do
    user = create(:user)
    inventory = create(:inventory, user:)
    inventory_foods = create_list(:inventory_food, 3, inventory:)

    login_as(user, scope: :user)

    visit inventory_path(inventory)

    expect(page).to have_content(inventory.name)

    within('table') do
      expect(page).to have_content('Food')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Actions')

      inventory_foods.each do |inventory_food|
        expect(page).to have_content(inventory_food.food.name)
        expect(page).to have_content(inventory_food.quantity)
        expect(page).to have_button('Remove')
      end
    end

    expect(page).to have_link('Add Food', href: new_inventory_inventory_food_path(inventory))
  end
end
