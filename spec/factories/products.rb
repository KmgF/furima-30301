FactoryBot.define do
  factory :product do
    name                    { 'モンスターボール'}
    description             { 'ポケモンを気軽にゲットし、連れ歩ける大発明！' }
    price                   { '1000000' }
    category_id             {4}
    status_id               {2}
    shipment_prefecture_id  {2}
    date_of_shipment_id     {2}
    delivery_fee_id         {2}

    association :user

    after(:build) do |product|
      product.image.attach(io: File.open('public/images/zel3.png'), filename: 'zel3.png')
    end
  end
end
