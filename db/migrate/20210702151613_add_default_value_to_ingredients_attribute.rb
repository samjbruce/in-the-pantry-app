class AddDefaultValueToIngredientsAttribute < ActiveRecord::Migration[6.1]
  def change
    change_column :ingredients, :have, :boolean, default: true
  end
end
