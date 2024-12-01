class Recipe < ApplicationRecord
  belongs_to :project
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags
  has_many :ingredient_recipes
  has_many :ingredients, through: :ingredient_recipes
end
