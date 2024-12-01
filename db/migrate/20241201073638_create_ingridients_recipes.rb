class CreateIngridientsRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :ingridients_recipes do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :ingridient, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
