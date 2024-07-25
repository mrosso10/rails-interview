require 'rails_helper'

RSpec.describe TodoItem do
  let(:todo_item) { create(:todo_item) }

  it 'is gets persisted' do
    expect(todo_item).to be_persisted
  end
end
