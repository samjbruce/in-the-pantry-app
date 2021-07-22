class RecipesController < ApplicationController

  def index

    formated_query_string = params[:query].gsub(/\s+/, "+")

    response = HTTP.get("https://api.spoonacular.com/recipes/findByIngredients?ingredients=#{formated_query_string}&ignorePantry=false&number=25&apiKey=#{Rails.application.credentials.spoonacular_api_key}")


    recipes = response.parse(:json)

    formatted_recipes = recipes.map do |recipe|
      {
        recipe_id: recipe["id"],
        title: recipe["title"],
        image_url: recipe["image"],
        used_ingredients: recipe["usedIngredients"].map { |ingredient| ingredient["name"] }.uniq
      }
    end
    

    render json: {recipes: formatted_recipes}
    


  end

  def show

    spoonacular_api_id = params[:spoonacular_api_id]
    response = HTTP.get("https://api.spoonacular.com/recipes/#{spoonacular_api_id}/information?apiKey=#{Rails.application.credentials.spoonacular_api_key}")
    similar_response = HTTP.get("https://api.spoonacular.com/recipes/#{spoonacular_api_id}/similar?apiKey=#{Rails.application.credentials.spoonacular_api_key}")

    recipe = response.parse(:json)
    similar_recipes = similar_response.parse(:json)

    formatted_instructions =  recipe["analyzedInstructions"].map do |instruction|
      instruction["steps"].map { |step| step["step"] }
    end

    prep_time_minutes = recipe["readyInMinutes"]
    if prep_time_minutes > 60
      hours = prep_time_minutes / 60
      minutes = prep_time_minutes % 60
      prep_time_formatted = "#{hours} Hours and #{minutes} Minutes"
    else
      prep_time_formatted = "#{prep_time_minutes} Minutes"
    end

    formatted_recipe = {
      recipe_id: recipe["id"],
      title: recipe["title"],
      summary: recipe["summary"],
      prep_time: prep_time_formatted,
      source: recipe["sourceName"],
      source_url: recipe["sourceUrl"],
      servings: recipe["servings"],
      image: recipe["image"],
      ingredients: recipe["extendedIngredients"].map { |ingredient| ingredient["originalString"]},
      instructions: formatted_instructions[0]
    }
    
    similar_recipes = similar_recipes.map do |recipe|
      prep_time_minutes = recipe["readyInMinutes"]
      if prep_time_minutes > 60
        hours = prep_time_minutes / 60
        minutes = prep_time_minutes % 60
        prep_time_formatted = "#{hours} Hours and #{minutes} Minutes"
      else
        prep_time_formatted = "#{prep_time_minutes} Minutes"
      end
      {
        title: recipe["title"],
        prep_time: prep_time_formatted
      }
    end

    render json: {formatted_recipe: formatted_recipe, similar_recipes: similar_recipes}

  end

end
