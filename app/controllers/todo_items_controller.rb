class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: %i[show edit update destroy]
  before_action :set_todo_list

  def new
    @todo_item = TodoItem.new
    render turbo_stream: turbo_stream.update(
      'new_todo_item', partial: 'form', locals: { todo_item: @todo_item })
  end

  def edit
    render turbo_stream: turbo_stream.update(
      @todo_item, partial: 'form', locals: { todo_item: @todo_item })
  end

  def create
    @todo_item = TodoItem.new(todo_item_params.merge(todo_list_id: @todo_list.id))

    if @todo_item.save
      redirect_to todo_list_path(@todo_list)
    else
      render turbo_stream: turbo_stream.update(
        'new_todo_item', partial: 'form', locals: { todo_item: @todo_item }),
        status: :unprocessable_entity
    end
  end

  def update
    if @todo_item.update(todo_item_params)
      render turbo_stream: turbo_stream.replace(@todo_item, @todo_item, locals: { todo_item: @todo_item })
    else
      render turbo_stream: turbo_stream.update(
        @todo_item, partial: 'form', locals: { todo_item: @todo_item }),
          status: :unprocessable_entity
    end
  end

  def destroy
    @todo_item.destroy

    render turbo_stream: turbo_stream.remove(@todo_item)
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_todo_item
    @todo_item = TodoItem.find(params[:id])
  end

  def todo_item_params
    params.require(:todo_item).permit(:description, :done, :todo_list_id)
  end
end
