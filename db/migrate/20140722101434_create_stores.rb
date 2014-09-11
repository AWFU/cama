class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.text :intro
      t.string :phone
      t.string :address
      t.string :country
      t.string :city
      t.string :district
      t.text :ophour
      t.text :latlng

      t.timestamps
    end
  end
end
