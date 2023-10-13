FactoryBot.define do
  factory :food do
    name { 'Sample Food' }
    measurement_unit { 'grams' }
    price { 10.0 }
  end
end
