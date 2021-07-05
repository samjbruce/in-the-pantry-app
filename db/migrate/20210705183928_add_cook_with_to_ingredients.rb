class AddCookWithToIngredients < ActiveRecord::Migration[6.1]
  def change
    add_column :ingredients, :cook_with, :string
  end
end
