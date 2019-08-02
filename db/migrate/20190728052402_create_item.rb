class CreateItem < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :description, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :stock, null: false
      t.timestamps
    end
  end
end
