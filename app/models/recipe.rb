class Recipe < ApplicationRecord
  belongs_to :project

  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  has_many :ingredient_recipes, dependent: :destroy
  has_many :ingredients, through: :ingredient_recipes

  has_many :recipe_recipes, foreign_key: :recipe_id, dependent: :destroy
  has_many :recipes, through: :recipe_recipes, source: :recipe_item

  has_many :inverse_recipe_recipes, class_name: "RecipeRecipe", foreign_key: :recipe_item_id, dependent: :destroy
  has_many :inverse_recipes, through: :inverse_recipe_recipes, source: :recipe

  accepts_nested_attributes_for :ingredient_recipes
  has_one_attached :image
  validates :name, presence: true
end
