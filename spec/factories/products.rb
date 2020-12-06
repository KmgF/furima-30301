FactoryBot.define do
  factory :product do
    name                    {Faker::Games::Zelda.item}
    description             {Faker::Lorem.sentence}
    price                   {Faker::Number.between(from:300,to:9999999)}
    
    association :user
    association :category
    association :status
    association :shipment_prefecture
    association :date_of_shipment
    association :delivery_fee
    
    after(:build) do |product|
      product.image.attach(io: File.open('public/images/zel3.png'), filename:'zel3.png')
    end

  end
end
