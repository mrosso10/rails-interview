require 'rails_helper'

RSpec.describe TodoList do
  let(:todo_list) { create(:todo_list) }

  it 'is gets persisted' do
    expect(todo_list).to be_persisted
  end
end
