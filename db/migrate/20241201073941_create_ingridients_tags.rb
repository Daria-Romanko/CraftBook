class CreateIngridientsTags < ActiveRecord::Migration[8.0]
  def change
    create_table :ingridients_tags do |t|
      t.references :ingridient, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
