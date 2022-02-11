class AddAdminDefaultFalseToUsers < ActiveRecord::Migration[7.0]
  def up
    change_column_default :users, :admin, false
  end

  def down
    change_column_default :users, :admin, nil
  end

end
