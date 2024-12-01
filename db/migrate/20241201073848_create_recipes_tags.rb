class CreateRecipesTags < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes_tags do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
