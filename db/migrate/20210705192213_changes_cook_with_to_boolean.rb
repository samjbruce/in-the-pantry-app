class ChangesCookWithToBoolean < ActiveRecord::Migration[6.1]
  def delete
    delete_column :ingredients, :cook_with, :string
  end
end
