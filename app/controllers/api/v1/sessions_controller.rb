class Api::V1::SessionsController < ApplicationController

  before_action :authenticate_with_token!, only: [:destroy]

  def create
    user_password = session_params[:password]
    user_email = session_params[:email].downcase
    user = User.find_by(email: user_email)

    if user && user.valid_password?(user_password)
      #do i need sign_in???
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end

  def verify_access_token
    user = User.find_by(auth_token: params[:session])
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
