class AddServesToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :serves, :integer
  end
end
