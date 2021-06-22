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
    ingredient.have = params[:have] || ingredient.have
    if ingredient.save
      render json: { message: "Ingredient successfully updated" }, 
      status: :ok
    else
      render json: { errors: ingredient.errors.full_messages },
      status: :bad_request
    end
  end

  def destroy
    ingredient = Ingredient.find(params[:id])
    ingredient.delete
    render json: { message: "Ingredient Deleted" }
  end

end
