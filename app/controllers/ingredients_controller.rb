class IngredientsController < ApplicationController

  def index
    ingredients = current_user.ingredients
    render json: ingredients
  end

  def create
    ingredient = Ingredient.new(
      name: params[:name],
      user_id: current_user.id,
      have: params[:have]
    )
    if ingredient.save
      render json: { message: ingredient },
      status: :created
    else
      render json: { errors: ingredient.errors.full_messages },
      status: :bad_request
    end
  end

  def update
    ingredient = Ingredient.find(params[:id])
    if current_user == ingredient.user
      ingredient.have = params[:have] || ingredient.have
      if ingredient.save
        render json: { message: "Ingredient successfully updated" }, 
        status: :ok
      else
        render json: { errors: ingredient.errors.full_messages },
        status: :bad_request
      end
    else
      render json: { errors: "Unauthorized" }, status: :unauthorized 
    end
  end

  def destroy
    ingredient = Ingredient.find(params[:id])
    if current_user == ingredient.user
      ingredient.delete
      render json: { message: "Ingredient Deleted" }
    else
      render json: { errors: "Unauthorized" }, status: :unauthorized 
    end
  end

end
