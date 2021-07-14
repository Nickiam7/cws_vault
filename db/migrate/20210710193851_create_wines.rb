class CreateWines < ActiveRecord::Migration[6.1]
  def change
    create_table :wines do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.integer :quantity
      t.string :vintage
      t.boolean :available
      t.string :image

      t.timestamps
    end
  end
end
