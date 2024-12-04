class AddProjectIdToIngredients < ActiveRecord::Migration[8.0]
  def change
    add_reference :ingredients, :project, foreign_key: true
  end
end
