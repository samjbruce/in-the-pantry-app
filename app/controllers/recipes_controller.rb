class RecipesController < ApplicationController

  def index

    user_ingredients = current_user.ingredients.where( "have = ?", true )
    # Will include login to toggle whether a user wants to actually cook with certain ingredients or not. A have = false will populate a shopping list page where users can choose which ingredients to keep in the cart
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
        used_ingredients: recipe["usedIngredients"].map { |ingredient| ingredient["name"] }.uniq
      }
    end

    render json: formatted_recipes

  end

  def show

    spoonacular_api_id = params[:spoonacular_api_id]
    response = HTTP.get("https://api.spoonacular.com/recipes/#{spoonacular_api_id}/information?apiKey=#{Rails.application.credentials.spoonacular_api_key}")

    recipe = response.parse(:json)

    formatted_recipe = {
      recipe_id: recipe["id"],
      title: recipe["title"],
      prep_time: recipe["readyInMinutes"],
      servings: recipe["servings"],
      image: recipe["image"],
      ingredients: recipe["extendedIngredients"].map { |ingredient| ingredient["originalString"]},
      instructions: recipe["analyzedInstructions"].map do |instruction|
        instruction["steps"].map { |step| step["step"] }
      end
    }
    render json: formatted_recipe

  end

end
