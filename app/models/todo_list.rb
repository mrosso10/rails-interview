class TodoList < ApplicationRecord
  validates :name, presence: true

  has_many :todo_items, dependent: :destroy

  after_create_commit do
    broadcast_prepend_to :todo_lists
  end

  after_destroy do
    broadcast_remove_to :todo_lists
  end

  def as_json(options = {})
    super(options).tap do |json|
      json[:todo_items] = todo_items.as_json if options[:include_items]
    end
  end
end
