class ChangeNameToDescription < ActiveRecord::Migration[7.0]
  def change
    rename_column :ingredients, :name, :description
  end
end
