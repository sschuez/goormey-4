class CreateInstructions < ActiveRecord::Migration[7.0]
  def change
    create_table :instructions do |t|
      t.belongs_to :recipe, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
