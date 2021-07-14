class AddRoleToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :role, :string, default: 'customer'
  end
end
