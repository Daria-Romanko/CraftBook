class Tag < ApplicationRecord
  has_many :recipe_tags, dependent: :destroy
  has_many :recipes, through: :recipe_tags
  has_many :ingredient_tags, dependent: :destroy
  has_many :ingredients, through: :ingredient_tags
  has_one_attached :image
  validates :name, presence: true
end
