class RemoveColumnsFromContact < ActiveRecord::Migration[7.0]
  def change
    remove_column :contacts, :name, :string
    remove_column :contacts, :topic, :string
    remove_column :contacts, :terms, :string
  end
end
