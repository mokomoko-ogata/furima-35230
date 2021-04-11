FactoryBot.define do
  factory :item do
    item_name {Faker::String.random( length: 1..40 )}
    explain {Faker::String.random( length: 1..1_000 )}
    category_id { 2 }
    condition_id { 2 }
    delivery_charge_id { 2 }
    prefecture_id { 2 }
    shipping_date_id { 2 }
    price {Faker::Number.between(from: 300, to: 9_999_999 )}
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
