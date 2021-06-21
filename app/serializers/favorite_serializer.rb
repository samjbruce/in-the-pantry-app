class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :recipe
end
