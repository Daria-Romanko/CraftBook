class CreateRecipeRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_recipes do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :recipe_item, null: false, foreign_key:  { to_table: :recipes }
      t.integer :quantity

      t.timestamps
    end
  end
end
