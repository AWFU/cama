class CreateProductStocks < ActiveRecord::Migration
  def change
    create_table :product_stocks do |t|
      t.integer :product_id
      t.string :name
      t.integer :amount
      t.boolean :assign_amount

      t.timestamps
    end
  end
end
