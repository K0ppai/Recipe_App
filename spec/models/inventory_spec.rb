require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let(:user) { User.create(name: 'John') }

  it 'is not valid without a name' do
    inventory = Inventory.new(
      user:
    )
    expect(inventory).not_to be_valid
  end

  it 'is not valid without a user_id' do
    inventory = Inventory.new(
      name: 'Sample Inventory'
    )
    expect(inventory).not_to be_valid
  end

  it 'is not valid if name is too long' do
    inventory = Inventory.new(
      name: 'A' * 256,
      user:
    )
    expect(inventory).not_to be_valid
  end
end
