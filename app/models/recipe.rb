class Recipe < ApplicationRecord
  belongs_to :project
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
  has_many :ingredient_recipes, dependent: :destroy
  has_many :ingredients, through: :ingredient_recipes
  accepts_nested_attributes_for :ingredient_recipes
  has_one_attached :image
  validates :name, presence: true
end
