require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:food) { Food.new(name: 'apple', measurement_unit: 'grams', price: 5) }
  before { food.save }

  it 'has many Inventory foods' do
    association = described_class.reflect_on_association(:inventory_foods)
    expect(association.macro).to eq :has_many
  end
  it 'has many Recipe foods' do
    association = described_class.reflect_on_association(:recipe_foods)
    expect(association.macro).to eq :has_many
  end
  it 'Must have name' do
    food.name = nil
    expect(food).to_not be_valid
  end
  it 'Must have Measurement Unit' do
    food.measurement_unit = nil
    expect(food).to_not be_valid
  end
  it 'Must have Measurement Unit' do
    food.measurement_unit = nil
    expect(food).to_not be_valid
  end
end
