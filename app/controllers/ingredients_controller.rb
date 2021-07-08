class IngredientsController < ApplicationController

  before_action :authenticate_user

  def index
    ingredients = current_user.ingredients
    render json: ingredients
  end

  def create
    ingredients = current_user.ingredients
    ingredient = Ingredient.new(
      name: params[:name],
      user_id: current_user.id,
      have: params[:have]
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
    ingredients = current_user.ingredients
    ingredient = Ingredient.find(params[:id])
    if ingredient.user_id == current_user.id
      if params[:have] == "1"
        ingredient.have = true
      elsif params[:have] == "2"
        ingredient.have = false
      end
      if params[:cook_with] == "1"
        ingredient.cook_with = true
      elsif params[:cook_with] == "2"
        ingredient.cook_with = false
      end
      # ingredient.have = !ingredient.have 
      # ingredient.cook_with = !ingredient.cook_with
      if ingredient.save
        render json: ingredients
      else
        render json: { errors: ingredient.errors.full_messages },
        status: :bad_request
      end
    else
      render json: {}, status: :unauthorized
    end
  end

  def destroy
    ingredients = current_user.ingredients
    ingredient = Ingredient.find(params[:id])
    if ingredient.user_id == current_user.id
      ingredient.delete
      render json: ingredients
    else
      render json: {}, status: :unauthorized
    end
  end

end
