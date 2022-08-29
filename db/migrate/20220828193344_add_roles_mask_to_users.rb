class AddRolesMaskToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :roles_mask, :integer, default:0
  end
end
