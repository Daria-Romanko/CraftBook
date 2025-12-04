class RecipeRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :recipe_item, class_name: "Recipe"

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
