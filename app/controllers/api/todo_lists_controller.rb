module Api
  class TodoListsController < ActionController::API
    include ErrorResponder

    # GET /api/todolists
    def index
      @todo_lists = TodoList.all

      render json: @todo_lists
    end

    def create
      model = TodoList.new(params.require(:todo_list).permit(:name))
      model.save!

      render json: model
    end
  end
end
