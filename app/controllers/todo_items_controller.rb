class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: %i[show edit update destroy]

  def index
    @todo_items = TodoItem.all
  end

  def show; end

  # GET /todo_items/new
  def new
    @todo_item = TodoItem.new
  end

  # GET /todo_items/1/edit
  def edit; end

  def create
    @todo_item = TodoItem.new(todo_item_params)

    if @todo_item.save
      redirect_to todo_item_url(@todo_item), notice: 'Todo item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo_item.update(todo_item_params)
      redirect_to todo_item_url(@todo_item), notice: 'Todo item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_item.destroy

    redirect_to todo_items_url, notice: 'Todo item was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo_item
    @todo_item = TodoItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def todo_item_params
    params.require(:todo_item).permit(:description, :done, :todo_list_id)
  end
end
