class TodoItem < ApplicationRecord
  belongs_to :todo_list

  validates :description, presence: true

  after_create_commit do
    broadcast_append_to todo_list
  end

  after_update_commit do
    broadcast_update_to todo_list
  end

  after_destroy do
    broadcast_remove_to todo_list
  end
end
