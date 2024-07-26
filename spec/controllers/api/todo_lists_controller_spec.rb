require 'rails_helper'

describe Api::TodoListsController do
  render_views

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

  describe 'GET show' do
    subject do
      get :show, params: { id: todo_list.id }
    end

    let(:todo_list) { create(:todo_list) }

    before { create(:todo_item, todo_list:) }

    it 'shows the list with the items' do
      subject
      json = response.parsed_body

      aggregate_failures 'includes the id and name' do
        expect(json.keys).to match_array(%w[id name todo_items])
        expect(json['id']).to eq(todo_list.id)
        expect(json['name']).to eq(todo_list.name)
        expect(json['todo_items']).to be_a Array
        expect(json['todo_items'].count).to eq 1
      end
    end
  end

  describe 'POST create' do
    subject do
      post :create, params: { todo_list: attributes }
    end

    let(:attributes) do
      attributes_for(:todo_list)
    end

    it 'responds with status ok' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'creates the todo list' do
      expect { subject }.to change(TodoList, :count).by(1)
    end

    context 'when the name is empty' do
      let(:attributes) do
        attributes_for(:todo_list, name: nil)
      end

      it 'returns with unprocessable_entity status' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH update' do
    subject do
      patch :update, params: { id: todo_list.id, todo_list: attributes }
    end

    let(:todo_list) { create(:todo_list) }

    let(:attributes) do
      attributes_for(:todo_list)
    end

    it 'responds with status ok' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'updates the todo list' do
      expect { subject }.to(change { todo_list.reload.name })
    end

    context 'when the name is empty' do
      let(:attributes) do
        attributes_for(:todo_list, name: nil)
      end

      it 'returns with unprocessable_entity status' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE destroy' do
    subject do
      delete :destroy, params: { id: todo_list.id }
    end

    let!(:todo_list) { create(:todo_list) }

    it 'destroys the list' do
      expect { subject }.to change(TodoList, :count).by(-1)
    end
  end
end
