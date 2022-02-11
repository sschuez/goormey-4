class AddPositionToInstructions < ActiveRecord::Migration[7.0]
  def change
    add_column :instructions, :position, :integer
  end
end
