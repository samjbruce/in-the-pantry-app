class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :image_url, :used_ingredients
end
