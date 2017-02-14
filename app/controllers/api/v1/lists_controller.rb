class Api::V1::ListsController < ApplicationController
  before_action :authenticate_with_token!

  respond_to :json
  def index
    user_id = current_user.id
    lists = List.where(user_id: user_id)
    render json: lists
  end

  def show
    list = List.find(params[:id])
    render json: list
  end

  def create
    user_id = current_user.id
    user = User.find(user_id)
    list = user.lists.new(list_params)

    if list.save
      render json: list, status: 201
    else
      render json: { errors: list.errors }, status: 422
    end
  end


  def destroy
    user_id = current_user.id
    lists = List.where(user_id: user_id)
    list = lists[list_params[:id]]
    list.destroy
    head 204
  end

  protected

    def list_params
      params.require(:list).permit(:name, :id)
    end

    def user_params
      params.require(:user).permit(:user_id)
    end
end
