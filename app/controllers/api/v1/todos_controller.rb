class Api::V1::TodosController < ApplicationController
  before_action :authenticate_with_token!

  respond_to :json
  def index
    debugger
    list_id = todo_params[:id]
    todos = Todo.where(list_id: list_id)
    render json: todos
  end

  def show
    list_id = params[:id]
    todos = Todo.where(list_id: list_id)
    render json: todos
  end

  def create
    list_id = todo_params[:id]
    list = List.find(list_id)
    todo = list.todos.new(name: todo_params[:name])

    if todo.save
      render json: todo, status: 201
    else
      render json: { errors: list.errors }, status: 422
    end
  end


  def destroy

    list_id = todo_params[:list_id]
    todos = Todo.where(list_id: list_id)
    todo = todos[todo_params[:id]]
    todo.destroy
    head 204
  end

  protected

    def todo_params
      params.require(:todo).permit(:name, :id, :list_id)
    end

    def user_params
      params.require(:user).permit(:user_id)
    end
end
