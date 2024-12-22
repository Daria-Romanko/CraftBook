class ChangeTags < ActiveRecord::Migration[8.0]
  def change
    add_column :tags, :project_id, :integer unless column_exists?(:tags, :project_id)
    add_column :tags, :quantity, :integer unless column_exists?(:tags, :quantity)
    add_foreign_key :tags, :projects, column: :project_id if foreign_key_exists?(:tags, :project_id) == false
  end
end
