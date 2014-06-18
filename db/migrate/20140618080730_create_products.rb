class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :productCate_id
      t.string :name
      t.integer :price
      t.integer :price_for_sale
      t.string :status

      t.timestamps
    end
  end
end
