class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :recipe_id, :title, :image_url, :used_ingredients
end
