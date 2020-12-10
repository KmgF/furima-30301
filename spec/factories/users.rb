FactoryBot.define do
  factory :user do
    nickname                { Faker::Name.name }
    email                   { Faker::Internet.free_email }
    # password                { Faker::Internet.password(min_length: 6,mix_case: true) }
    password                { 'test1test1' }
    password_confirmation   { password }
    first_name              { '安倍' }
    family_name             { '晋三' }
    first_name_kana         { 'アベ' }
    family_name_kana        { 'シンゾウ' }
    birthday                { Faker::Date.birthday(min_age: 0, max_age: 100) }
  end
end
