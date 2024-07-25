module Api
  class TodoItemsController < ActionController::API
    include ErrorResponder

    before_action :set_todo_list
    before_action :set_todo_item, only: %i[show update destroy]

    # GET /api/todolists
    def index
      @todo_items = TodoItem.where(todo_list_id: @todo_list)

      render json: @todo_items
    end

    def show
      render json: @todo_item
    end

    def create
      model = TodoItem.new(todo_item_params)
      model.todo_list_id = params[:todo_list_id]
      model.save!

      render json: model
    end

    def update
      @todo_item.update!(todo_item_params)

      render json: @todo_item
    end

    def destroy
      @todo_item.destroy!

      head :ok
    end

    private

    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    def set_todo_item
      @todo_item = @todo_list.todo_items.find(params[:id])
    end

    def todo_item_params
      params.require(:todo_item).permit(:description, :done)
    end
  end
end
