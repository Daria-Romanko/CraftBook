class RenameIngridientsTagsToIngredientsTags < ActiveRecord::Migration[8.0]
  def change
    rename_table :ingridients_tags, :ingredients_tags
  end
end
