class CreateProductCates < ActiveRecord::Migration
  def change
    create_table :product_cates do |t|
      t.integer :parent_id
      t.string :name
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.timestamps
    end
  end
end
