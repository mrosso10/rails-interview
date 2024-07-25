class TodoList < ApplicationRecord
  validates :name, presence: true

  after_create_commit do
    broadcast_prepend_to :todo_lists
  end

  after_destroy do
    broadcast_remove_to :todo_lists
  end
end
