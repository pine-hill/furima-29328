require 'faker'

FactoryBot.define do
  factory :ordered_item_address do
    post_code                   {'206-0824'}
    prefecture_id               {Faker::Number.within(range:2..48)}
    city                        {'杉並区浜田山'}
    block                       {'3-34-25'}
    building_name               {'コーポやくしま202号室'}
    phone_number                {Faker::PhoneNumber.subscriber_number(length: 11)}
    token                       {"111111111111111111111"}
  end
end