class AddShowUsernameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :show_username, :boolean
  end
end
