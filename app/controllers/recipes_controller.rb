class RecipesController < ApplicationController

  def index

    user_ingredients = current_user.ingredients.where( "have = ?", true )
    ingredient_names = []
    user_ingredients.each do |ingredient_name|
      ingredient_names << ingredient_name["name"]
    end

    response = HTTP.get("https://api.spoonacular.com/recipes/findByIngredients?ingredients=#{ingredient_names[0]},#{ingredient_names[1]},#{ingredient_names[2]},#{ingredient_names[3]}&ignorePantry=false&number=15&apiKey=#{Rails.application.credentials.spoonacular_api_key}")

    recipes = response.parse(:json)

    formatted_recipes = recipes.map do |recipe|
      {
        recipe_id: recipe["id"],
        title: recipe["title"],
        image_url: recipe["image"],
        used_ingredients: recipe["usedIngredients"].map do |ingredient|
          ingredient["name"]
        end
      }
    end

    render json: formatted_recipes

  end

  def show

    spoonacular_api_id = params[:spoonacular_api_id]
    response = HTTP.get("https://api.spoonacular.com/recipes/#{spoonacular_api_id}/information?apiKey=#{Rails.application.credentials.spoonacular_api_key}")
    recipe = response.parse(:json)
    render json: recipe

  end

end
