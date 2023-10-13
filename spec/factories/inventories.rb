FactoryBot.define do
  factory :inventory do
    name { 'Example Inventory' }
    description { 'Example description' }
    association :user, factory: :user
  end
end
