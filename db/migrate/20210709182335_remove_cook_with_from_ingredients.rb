class RemoveCookWithFromIngredients < ActiveRecord::Migration[6.1]
  def change
    remove_column :ingredients, :cook_with, :boolean
  end
end
