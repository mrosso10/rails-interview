module Api
  class TodoListsController < ActionController::API
    include ErrorResponder

    before_action :set_todo_list, only: %i[show update destroy]

    def index
      @todo_lists = TodoList.all

      render json: @todo_lists
    end

    def show
      render json: @todo_list.as_json(include_items: true)
    end

    def create
      model = TodoList.create!(todo_list_params)

      render json: model
    end

    def update
      model = @todo_list.update!(todo_list_params)

      render json: model
    end

    def destroy
      @todo_list.destroy!

      head :ok
    end

    private

    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    def todo_list_params
      params.require(:todo_list).permit(:name)
    end
  end
end
