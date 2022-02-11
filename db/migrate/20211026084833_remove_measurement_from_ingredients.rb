class RemoveMeasurementFromIngredients < ActiveRecord::Migration[7.0]
  def change
    remove_column :ingredients, :measurement, :string
    remove_column :ingredients, :amount, :integer
  end
end
