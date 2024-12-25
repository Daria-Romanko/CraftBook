class Project < ApplicationRecord
  belongs_to :user
  has_many :recipes, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :tags, dependent: :destroy
end
