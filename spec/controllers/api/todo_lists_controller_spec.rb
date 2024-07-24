require 'rails_helper'

describe Api::TodoListsController do
  render_views

  describe 'POST create' do
    subject do
      post :create, params: body
    end

    let(:body) do
      {
        todo_list: {
          name:
        }
      }
    end
    let(:name) { 'La tarea' }

    it 'responds with status ok' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'creates the todo list' do
      expect { subject }.to change(TodoList, :count).by(1)
    end

    context 'when the name is empty' do
      let(:name) { '' }

      it 'returns with unprocessable_entity status' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET index' do
    let!(:todo_list) { TodoList.create(name: 'Setup RoR project') }

    it 'returns a success code' do
      get :index, format: :json

      expect(response).to have_http_status(:ok)
    end

    it 'includes todo list records' do
      get :index, format: :json

      todo_lists = response.parsed_body

      aggregate_failures 'includes the id and name' do
        expect(todo_lists.count).to eq(1)
        expect(todo_lists[0].keys).to match_array(%w[id name])
        expect(todo_lists[0]['id']).to eq(todo_list.id)
        expect(todo_lists[0]['name']).to eq(todo_list.name)
      end
    end
  end
end
