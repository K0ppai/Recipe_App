require 'rails_helper'

RSpec.feature 'Add Food to Inventory Page' do
  scenario 'User visits the Add Food to Inventory page' do
    user = create(:user)
    inventory = create(:inventory, user: user)
    food = create_list(:food, 5)

    login_as(user, scope: :user)

    visit new_inventory_inventory_food_path(inventory)

    expect(page).to have_content("Add Food to #{inventory.name}")

    select_field = find('select#inventory_food_food_id')
    expect(select_field).to have_content('Select a Food')

    expect(page).to have_field('Quantity')
    expect(page).to have_button('Add Food')

    expect(page).to have_link('Back', href: inventory_path(inventory))
  end
end
