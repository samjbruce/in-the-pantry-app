class UsersController < ApplicationController

  before_action :authenticate_user

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      image_url: params[:image_url]
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    user = User.find(params[:id])
    if user == current_user
      render json: user
    else
      render json: {}, status: :unauthorized
    end
  end

  def update
    user = User.find(params[:id])
    if current_user.id == user.id
      user.name = params[:name] || user.name
      user.email = params[:email] || user.email
      user.image_url = params[:image_url] || user.image_url
      if user.save
        render json: { message: "User successfully updated" },
        status: :ok
      else
        render json: { errors: user.errors.full_messages },
        status: :bad_request
      end
    else
      render json: { errors: "Unauthorized" }, status: :unauthorized
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user == user
      user.destroy
      render json: { message: "User successfully deleted"}
    else
      render json: { errors: "Unauthorized" }, status: :unauthorized
    end
  end

end
