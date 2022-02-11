class AddWizardCompleteToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :wizard_complete, :boolean
  end
end
