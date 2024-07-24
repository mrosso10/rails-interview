require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/todo_lists' do
  # This should return the minimal set of attributes required to create a valid
  # TodoList. As you add validations to TodoList, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    attributes_for(:todo_list)
  end

  let(:invalid_attributes) do
    attributes_for(:todo_list, name: nil)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      TodoList.create! valid_attributes
      get todo_lists_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      todo_list = TodoList.create! valid_attributes
      get todo_list_url(todo_list)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_todo_list_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      todo_list = TodoList.create! valid_attributes
      get edit_todo_list_url(todo_list)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new TodoList' do
        expect do
          post todo_lists_url, params: { todo_list: valid_attributes }
        end.to change(TodoList, :count).by(1)
      end

      it 'redirects to the created todo_list' do
        post todo_lists_url, params: { todo_list: valid_attributes }
        expect(response).to redirect_to(todo_list_url(TodoList.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new TodoList' do
        expect do
          post todo_lists_url, params: { todo_list: invalid_attributes }
        end.not_to change(TodoList, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post todo_lists_url, params: { todo_list: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for(:todo_list)
      end

      it 'updates the requested todo_list' do
        todo_list = TodoList.create! valid_attributes
        patch todo_list_url(todo_list), params: { todo_list: new_attributes }
        todo_list.reload
        expect(todo_list.reload.name).to eq new_attributes[:name]
      end

      it 'redirects to the todo_list' do
        todo_list = TodoList.create! valid_attributes
        patch todo_list_url(todo_list), params: { todo_list: new_attributes }
        todo_list.reload
        expect(response).to redirect_to(todo_list_url(todo_list))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        todo_list = TodoList.create! valid_attributes
        patch todo_list_url(todo_list), params: { todo_list: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested todo_list' do
      todo_list = TodoList.create! valid_attributes
      expect do
        delete todo_list_url(todo_list)
      end.to change(TodoList, :count).by(-1)
    end

    it 'redirects to the todo_lists list' do
      todo_list = TodoList.create! valid_attributes
      delete todo_list_url(todo_list)
      expect(response).to redirect_to(todo_lists_url)
    end
  end
end
