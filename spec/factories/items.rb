require 'faker'

FactoryBot.define do
  factory :item do
    name                  {Faker::Name.name}
    price                 {Faker::Number.within(range: 300..999999)}
    description           {Faker::Lorem.sentence}
    category_id           {Faker::Number.within(range:2..10)}
    condition_id          {Faker::Number.within(range:2..7)}
    handling_time_id      {Faker::Number.within(range:2..3)}
    postage_id            {Faker::Number.within(range:2..4)}
    prefecture_id         {Faker::Number.within(range:2..48)}
    association :user
  end
end