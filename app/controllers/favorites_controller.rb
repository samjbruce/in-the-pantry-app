class FavoritesController < ApplicationController

  before_action :authenticate_user

  def index
    favorites = current_user.favorites
    render json: favorites
  end

  def create
    favorite = Favorite.new(
      user_id: current_user.id,
      spoonacular_api_id: params[:spoonacular_api_id]
    )
    if favorite.save
      render json: favorite,
      status: :created
    else
      render json: { errors: favorite.errors.full_messages },
      status: :bad_request
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    if current_user.id == favorite.user_id
      favorite.delete
      render json: {message: "Destroyed"}
    else
      render json: {}, status: :unauthorized
    end
  end

end
