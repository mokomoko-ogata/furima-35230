FactoryBot.define do
  factory :purchase_destination do
    zip_code {'123-4567'}
    prefecture_id {2}
    municipality { Faker::String.random }
    address {Faker::String.random}
    telephone_number {Faker::Number.number(digits: 11)}
    token {"tok_abcdefghijk00000000000000000"}
  end
end
