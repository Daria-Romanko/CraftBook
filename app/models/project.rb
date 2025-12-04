class Project < ApplicationRecord
  belongs_to :user
  has_many :recipes, dependent: :destroy
  has_many :ingredients, dependent: :destroy, through: :recipes
  has_many :tags, dependent: :destroy

  def as_json(options = {})
    super(options.merge(
      include: {
        recipes: { methods: :image_url },
        ingredients: { methods: :image_url },
        tags: { methods: :image_url }
      }
    ))
  end
end
