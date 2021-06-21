class FavoritesController < ApplicationController

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
      render json: { message: favorite },
      status: :created
    else
      render json: { errors: favorite.errors.full_messages },
      status: :bad_request
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.delete
    render json: { message: "Unfavorited" }
  end

end
