class TodoItem < ApplicationRecord
  belongs_to :todo_list

  validates :description, presence: true

  broadcasts_to ->(todo_item) { todo_item.todo_list }
end
