class RenameIngridientsRecipesToIngredientsRecipes < ActiveRecord::Migration[8.0]
  def change
    rename_table :ingridients_recipes, :ingredients_recipes
  end
end
