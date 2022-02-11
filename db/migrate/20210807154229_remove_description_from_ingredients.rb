class RemoveDescriptionFromIngredients < ActiveRecord::Migration[7.0]
  def change
    remove_column :ingredients, :description, :string
  end
end
