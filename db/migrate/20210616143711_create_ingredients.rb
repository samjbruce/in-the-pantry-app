class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :user_id
      t.boolean :have

      t.timestamps
    end
  end
end
