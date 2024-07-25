FactoryBot.define do
  factory :todo_item do
    description { Faker::Lorem.sentence }
    done { [true, false].sample }
    todo_list
  end
end
