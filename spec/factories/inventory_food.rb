FactoryBot.define do
  factory :inventory_food do
    association :inventory
    association :food
    quantity { 1 }
  end
end
