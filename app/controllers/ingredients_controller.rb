class IngredientsController < ApplicationController

  before_action :authenticate_user

  def index
    ingredients = current_user.ingredients
    render json: ingredients
  end

  def create
    ingredient = Ingredient.new(
      name: params[:name].capitalize(),
      user_id: current_user.id
    )
    if ingredient.save
      render json: ingredient,
      status: :created
    else
      render json: { errors: ingredient.errors.full_messages },
      status: :bad_request
    end
  end

  def update
    ingredient = Ingredient.find(params[:id])
    if ingredient.user_id == current_user.id
      if params[:have] == true
        ingredient.have = true
      elsif params[:have] == false
        ingredient.have = false
      end
      if ingredient.save
        render json: ingredient
      else
        render json: { errors: ingredient.errors.full_messages },
        status: :bad_request
      end
    else
      render json: {}, status: :unauthorized
    end
  end

  def destroy
    ingredient = Ingredient.find(params[:id])
    if ingredient.user_id == current_user.id
      ingredient.delete
      render json: {message: "destroyed"}
    else
      render json: {}, status: :unauthorized
    end
  end

end
