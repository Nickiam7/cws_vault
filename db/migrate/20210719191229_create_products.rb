class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :type
      t.string :description
      t.integer :price
      t.integer :quantity
      t.boolean :available
      t.string :vintage
      t.string :image

      t.timestamps
    end
  end
end
