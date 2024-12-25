class RecipeRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :recipe_item, class_name: "Recipe"
end
