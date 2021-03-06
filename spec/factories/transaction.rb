FactoryBot.define do
  factory :transaction do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    prefecture_id { 2 }
    municipality { '東京' }
    address { '東京1−１' }
    building_name { '東京ビル' }
    phone_number { '12345678901' }
  end
end
