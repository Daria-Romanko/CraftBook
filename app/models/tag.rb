class Tag < ApplicationRecord
  has_many :recipe_tags
  has_many :recipes, through: :recipe_tags
  has_many :ingredient_tags
  has_many :ingredients, through: :ingredient_tags
end
