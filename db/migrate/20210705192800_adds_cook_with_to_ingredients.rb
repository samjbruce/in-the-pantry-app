class AddsCookWithToIngredients < ActiveRecord::Migration[6.1]
  def change
    add_column :ingredients, :cook_with, :boolean
  end
end
