class AddFeaturedToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :featured, :boolean
  end
end
