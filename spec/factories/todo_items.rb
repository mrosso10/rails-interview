FactoryBot.define do
  factory :todo_item do
    description { 'MyString' }
    done { false }
    todo_list
  end
end
