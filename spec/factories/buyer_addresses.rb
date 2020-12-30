FactoryBot.define do
  factory :buyer_address do
    post_number   { '123-4567' }
    prefecture_id { 2 }
    city          { '札幌市' }
    house_number  { '1-1-1' }
    building_name { '札幌ドーム' }
    tel           { '09012345678' }
    token         { 'tok_abcdefghijk00000000000000000' }
    user_id       { 1 }
    product_id    { 1 }
  end
end
