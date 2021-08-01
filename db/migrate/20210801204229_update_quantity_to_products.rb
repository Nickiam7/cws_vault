class UpdateQuantityToProducts < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :quantity, :integer, null: false, default: 0
  end
end
