class Project < ApplicationRecord
  belongs_to :user
  has_many :recipes
  has_many :ingredients
end
