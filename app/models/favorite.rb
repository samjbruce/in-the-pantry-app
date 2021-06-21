class Favorite < ApplicationRecord

  belongs_to :user
  validates :spoonacular_api_id, presence: true, uniqueness: true

  def recipe
    response = HTTP.get("https://api.spoonacular.com/recipes/#{spoonacular_api_id}/information?apiKey=#{Rails.application.credentials.spoonacular_api_key}")
    api_recipe_object = response.parse(:json)
    return {
      title: api_recipe_object["title"],
      prep_time_minutes: api_recipe_object["readyInMinutes"],
      image_url: api_recipe_object["image"]
    }
  end

end
