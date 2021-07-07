class RecipesController < ApplicationController

  def index

    user_ingredients = current_user.ingredients.where( "cook_with = ?", true )
    formatted_ingredient_names = []
    user_ingredients.each do |ingredient_name|
      formatted_ingredient_names << ingredient_name["name"].gsub(/\s+/, "+")
    end
    ingredient_names = []
    user_ingredients.each do |ingredient_name|
      ingredient_names << ingredient_name["name"]
    end

    response = HTTP.get("https://api.spoonacular.com/recipes/findByIngredients?ingredients=#{formatted_ingredient_names[0]},#{formatted_ingredient_names[1]},#{formatted_ingredient_names[2]},#{formatted_ingredient_names[3]}&ignorePantry=false&number=25&apiKey=#{Rails.application.credentials.spoonacular_api_key}")

    recipes = response.parse(:json)

    formatted_recipes = recipes.map do |recipe|
      {
        recipe_id: recipe["id"],
        title: recipe["title"],
        image_url: recipe["image"],
        used_ingredients: recipe["usedIngredients"].map { |ingredient| ingredient["name"] }.uniq
      }
    end

    render json: {recipes: formatted_recipes, ingredient_names: ingredient_names }
    


  end

  def show

    spoonacular_api_id = params[:spoonacular_api_id]
    response = HTTP.get("https://api.spoonacular.com/recipes/#{spoonacular_api_id}/information?apiKey=#{Rails.application.credentials.spoonacular_api_key}")

    recipe = response.parse(:json)

    formatted_instructions =  recipe["analyzedInstructions"].map do |instruction|
      instruction["steps"].map { |step| step["step"] }
    end

    formatted_recipe = {
      recipe_id: recipe["id"],
      title: recipe["title"],
      prep_time: recipe["readyInMinutes"],
      servings: recipe["servings"],
      image: recipe["image"],
      ingredients: recipe["extendedIngredients"].map { |ingredient| ingredient["originalString"]},
      instructions: formatted_instructions[0]
    }
    render json: formatted_recipe

  end

end
