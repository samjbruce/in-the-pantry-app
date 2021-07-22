class Favorite < ApplicationRecord

  belongs_to :user
  validates :spoonacular_api_id, presence: true

  def recipe
    response = HTTP.get("https://api.spoonacular.com/recipes/#{spoonacular_api_id}/information?apiKey=#{Rails.application.credentials.spoonacular_api_key}")
    api_recipe_object = response.parse(:json)
    prep_time_minutes = api_recipe_object["readyInMinutes"]
    if prep_time_minutes > 60
      hours = prep_time_minutes / 60
      minutes = prep_time_minutes % 60
      prep_time_formatted = "#{hours} Hours and #{minutes} Minutes"
    else
      prep_time_formatted = "#{prep_time_minutes} Minutes"
    end
    return {
      recipe_id: api_recipe_object["id"],
      title: api_recipe_object["title"],
      prep_time: prep_time_formatted,
      image_url: api_recipe_object["image"],
    }
  end

end
