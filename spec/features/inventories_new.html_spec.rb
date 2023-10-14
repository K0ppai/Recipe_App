require 'rails_helper'

RSpec.feature 'Add New Inventory Page' do
  scenario 'User visits the Add New Inventory page' do
    user = create(:user)

    login_as(user, scope: :user)

    visit new_inventory_path

    expect(page).to have_content('Add a New Inventory')
    expect(page).to have_field('Name')
    expect(page).to have_field('Description')
    expect(page).to have_button('Create Inventory')

    expect(page).to have_link('Back', href: inventories_path)
  end
end
