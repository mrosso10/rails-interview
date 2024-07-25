require 'rails_helper'

describe Api::TodoItemsController do
  describe 'GET index' do
    subject do
      get :index, params: { todo_list_id: todo_list.id }
    end

    let(:todo_list) do
      create(:todo_list)
    end

    let!(:todo_item) do
      create(:todo_item, todo_list:)
    end

    it 'responds ok' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'returns the items' do
      subject
      items = response.parsed_body

      aggregate_failures 'includes the id and name' do
        expect(items.count).to eq(1)
        expect(items[0].keys).to match_array(
          %w[created_at description id done todo_list_id updated_at]
        )
        expect(items[0]['id']).to eq(todo_item.id)
        expect(items[0]['description']).to eq(todo_item.description)
        expect(items[0]['done']).to eq(todo_item.done)
      end
    end
  end

  describe 'GET show' do
    subject do
      get :show, params: { todo_list_id: todo_list.id, id: todo_item.id }
    end

    let(:todo_list) { create(:todo_list) }
    let!(:todo_item) { create(:todo_item, todo_list:) }

    it 'shows the item' do
      subject

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    subject do
      post :create, params: { todo_item: valid_attributes }.merge(todo_list_id: todo_list.id)
    end

    let(:todo_list) { create(:todo_list) }
    let(:valid_attributes) do
      attributes_for(:todo_item).merge(todo_list_id: todo_list.id)
    end

    it 'creates the item' do
      expect { subject }.to change(TodoItem, :count).by(1)
    end
  end

  describe 'PATCH update' do
    subject do
      patch :update, params: {
        todo_list_id: todo_list.id,
        id: todo_item.id,
        todo_item: new_attributes
      }
    end

    let(:todo_list) { create(:todo_list) }
    let(:todo_item) { create(:todo_item, todo_list:) }

    let(:new_attributes) do
      attributes_for(:todo_item)
    end

    it 'updates the item' do
      subject
      todo_item.reload
      expect(todo_item.description).to eq new_attributes[:description]
    end
  end

  describe 'DELETE update' do
    subject do
      delete :destroy, params: {
        todo_list_id: todo_list.id,
        id: todo_item.id
      }
    end

    let(:todo_list) { create(:todo_list) }
    let!(:todo_item) { create(:todo_item, todo_list:) }

    it 'destroys the item' do
      expect { subject }.to change(TodoItem, :count).by(-1)
    end
  end
end
