class RecipeTag < ApplicationRecord
  belongs_to :recipe
  belongs_to :tag

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
