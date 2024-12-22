class Ingredient < ApplicationRecord
  has_many :ingredient_recipes, dependent: :destroy
  has_many :recipes, through: :ingredient_recipes
  has_many :ingredient_tags, dependent: :destroy
  has_many :tags, through: :ingredient_tags
  has_one_attached :image

  validates :name, presence: true
end
